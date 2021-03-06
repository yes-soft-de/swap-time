<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\SwapItemEntity;
use App\Manager\CommentManager;
use App\Manager\ImageManager;
use App\Manager\SwapItemManager;
use App\Manager\SwapManager;
use App\Request\SwapItemCreateRequest;
use App\Response\ImageResponse;
use App\Response\SwapItemCreateResponse;
use App\Response\SwapItemsResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SwapItemService
{
    private $autoMapping;
    private $swapItemManager;
    private $commentService;
    private $imageService;
    private $interactionService;
    private $params;
    private $swapManager;

    public function __construct(AutoMapping $autoMapping, SwapItemManager $swapItemManager, CommentService $commentService,
                                ImageService $imageService, InteractionService $interactionService,
                                ParameterBagInterface $params, SwapManager $swapManager)
    {
        $this->autoMapping = $autoMapping;
        $this->swapItemManager = $swapItemManager;
        $this->commentService = $commentService;
        $this->imageService = $imageService;
        $this->interactionService = $interactionService;

        $this->params = $params->get('upload_base_url').'/';;
        $this->swapManager = $swapManager;
    }

    public function swapItemCreate(SwapItemCreateRequest $request)
    {
        $item = $this->swapItemManager->swapItemCreate($request);

        return $this->autoMapping->map(SwapItemEntity::class,SwapItemCreateResponse::class, $item);
    }

    public function getSwapItems($userID)
    {
        $itemsResponse = [];

        $items = $this->swapItemManager->getSwapItems();

        foreach ($items as $item)
        {
            $item['mainImage'] =  $this->specialLinkCheck($item['specialLink']).$item['mainImage'];
            //
            $commentsCount = $this->commentService->commentsNumber($item['id']);
            $item['commentNumber'] = $commentsCount;
            //
            $images = $this->imageService->getImages($item['id']);
            $item['images'] = $images;
            //
            $lovedCount = $this->interactionService->getLove($item['id']);
            $item['interaction']['loved'] = $lovedCount;
            //
            $lovedCheck = $this->interactionService->checkUserLoved($item['id'], $userID);
            if($lovedCheck != false)
            {
                $item['interaction']['checkLoved'] = true;
                $item['interaction']['lovedID'] = $lovedCheck[0]['id'];
            }
            else
            {
                $item['interaction']['checkLoved'] = false;
                $item['interaction']['lovedID'] = 0;
            }
            //
            $comments = $this->commentService->getCommentsByID($item['id']);
            $item['comments']= $comments;

            $itemsResponse[] = $this->autoMapping->map('array', SwapItemsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapItemByUserID($userID)
    {
        $itemsResponse = [];
        $items = $this->swapItemManager->getSwapItemByUserID($userID);

        foreach ($items as $item)
        {
            $item['mainImage'] =  $this->specialLinkCheck($item['specialLink']).$item['mainImage'];
            //
            $commentsCount = $this->commentService->commentsNumber($item['id']);
            $item['commentNumber'] = $commentsCount;
            //
            $lovedCount = $this->interactionService->getLove($item['id']);
            $item['interaction']['loved'] = $lovedCount;
            //
            $lovedCheck = $this->interactionService->checkUserLoved($item['id'], $userID);
            $item['interaction']['checkLoved'] = $lovedCheck;
            //
            $comments = $this->commentService->getCommentsByID($item['id']);
            $item['comments']= $comments;
            //
            $images = $this->imageService->getImages($item['id']);
            $item['images'] = $images;
            //

            $itemsResponse[] = $this->autoMapping->map('array', SwapItemsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapItemByID($userID, $id)
    {
        $item = $this->swapItemManager->getSwapItemByID($id);

        $item['mainImage'] =  $this->specialLinkCheck($item['specialLink']).$item['mainImage'];

        /** @var SwapItemsResponse $itemsResponse */
        $itemsResponse = $this->autoMapping->map('array', SwapItemsResponse::class, $item);

        //
        $commentsCount = $this->commentService->commentsNumber($id);
        $itemsResponse->commentNumber = $commentsCount;
        //
        $comments = $this->commentService->getCommentsByID($id);
        $itemsResponse->comments = $comments;
        //
        $images = $this->imageService->getImages($id);
        $itemsResponse->images = $images;
        //
        $isRequested = $this->swapManager->getSwapByItemAndUserID($userID, $id);
        $itemsResponse->isRequested = $isRequested;

        return $itemsResponse;
    }

    public function specialLinkCheck($bool)
    {
        if ($bool == false)
        {
            return $this->params;
        }
    }

    public function deleteSwapItem($swapItemID)
    {
        return $this->swapItemManager->deleteSwapItem($swapItemID);
    }

    public function getById($id)
    {
        $item = $this->swapItemManager->getSwapItemByID($id);

        return $this->autoMapping->map('array', SwapItemsResponse::class, $item);
    }
}