<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\SwapEntity;
use App\Manager\SwapManager;
use App\Request\SwapCreateRequest;
use App\Request\SwapUpdateRequest;
use App\Response\SwapCreateResponse;
use App\Response\SwapItemsResponse;
use App\Response\SwapsResponse;
use App\Service\UserService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SwapService
{
    private $autoMapping;
    private $swapManager;
    private $params;
    private $userService;
    private $swapItemService;

    public function __construct(AutoMapping $autoMapping, SwapManager $swapManager, ParameterBagInterface $params,
     UserService $userService, SwapItemService $swapItemService)
    {
        $this->autoMapping = $autoMapping;
        $this->swapManager = $swapManager;
        $this->userService = $userService;
        $this->swapItemService = $swapItemService;
        $this->params = $params->get('upload_base_url').'/';
    }

    public function swapCreate(SwapCreateRequest $request)
    {
        $item = $this->swapManager->swapCreate($request);

        $response = $this->autoMapping->map(SwapEntity::class,SwapCreateResponse::class, $item);

        return $response;
    }

    public function getSwaps()
    {
        $itemsResponse = [];
        $items = $this->swapManager->getSwaps();

        foreach ($items as $item)
        {
            //GET INFO
            //get users' info
            $userOne = $this->userService->getUserProfileByUserID($item['userIdOne']);
            $userTwo = $this->userService->getUserProfileByUserID($item['userIdTwo']);
            //get swap items' info
            $swapItemOne = $this->swapItemService->getById($item['swapItemIdOne']);
            $swapItemTwo = $this->swapItemService->getById($item['swapItemIdTwo']);
            //dd($swapItemOne);
            //SET INFO
            //set first user info
            $item['userOneName'] = $userOne[0]->getUserName();
            $item['userOneImage'] = $userOne[0]->getImage();
            //set second user info
            $item['userTwoName'] = $userTwo[0]->getUserName();
            $item['userTwoImage'] = $userTwo[0]->getImage();
            //set swap items' info
            if($swapItemOne != null)
            {
                $item['swapItemOneImage'] = $swapItemOne->getMainImage();
            }
            if($swapItemTwo != null)
            {
                $item['swapItemTwoImage'] = $swapItemTwo->getMainImage();
            }

            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapByID($id)
    {
        $itemsResponse = [];
        $result = $this->swapManager->getSwapByID($id);

        foreach ($result as $item) {

            $userOne = $this->userService->getUserProfileByUserID($item->getUserIdOne());
            $userTwo = $this->userService->getUserProfileByUserID($item->getUserIdTwo());
            //get swap items' info
            $swapItemOne = $this->swapItemService->getById($item->getSwapItemIdOne());
            $swapItemTwo = $this->swapItemService->getById($item->getSwapItemIdTwo());

            $itemsResponse[] = $this->autoMapping->map(SwapEntity::class, SwapsResponse::class, $item);

            //SET INFO
            //set first user info

            $itemsResponse[0]->setUserOneName($userOne[0]->getUserName());
            $itemsResponse[0]->setUserOneImage($userOne[0]->getImage());
            //set second user info
            $itemsResponse[0]->setUserTwoName($userTwo[0]->getUserName());
            $itemsResponse[0]->setUserTwoImage($userTwo[0]->getImage());
            //set swap items' info
            $itemsResponse[0]->setSwapItemOneImage($swapItemOne->getMainImage());
            $itemsResponse[0]->setSwapItemTwoImage($swapItemTwo->getMainImage());
        }

        return $itemsResponse;
    }

    public function deleteSwap($id)
    {
        return $this->swapManager->deleteSwap($id);
    }

    public function updateSwap(SwapUpdateRequest $request)
    {
        $item = $this->swapManager->updateSwap($request);

        return $this->autoMapping->map(SwapEntity::class,SwapsResponse::class, $item);
    }

    public function getSwapsByUserID($userID)
    {
        $itemsResponse = [];
        $items = $this->swapManager->getSwapsByUserID($userID);

        foreach ($items as $item)
        {
            $item['userOneImage'] = $this->params.$item['userOneImage'];
            $item['userTwoImage'] = $this->params.$item['userTwoImage'];
            $item['swapItemOneImage'] = $this->specialLinkCheck($item['itemOneSpecialImage']).$item['swapItemOneImage'];
            $item['swapItemTwoImage'] = $this->specialLinkCheck($item['itemTwoSpecialImage']).$item['swapItemTwoImage'];

            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function specialLinkCheck($bool)
    {
        if ($bool == false)
        {
            return $this->params;
        }
    }

    public function getSwapByItemAndUserID($userID, $itemID)
    {
        return $this->swapManager->getSwapByItemAndUserID($userID, $itemID);
    }
}