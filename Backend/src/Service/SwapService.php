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
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SwapService
{
    private $autoMapping;
    private $swapManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, SwapManager $swapManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->swapManager = $swapManager;
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
            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapByID($id)
    {
        $item = $this->swapManager->getSwapByID($id);

        $itemsResponse = $this->autoMapping->map(SwapEntity::class, SwapsResponse::class, $item);

        return $itemsResponse;
    }

    public function deleteSwap($id)
    {
        return $this->swapManager->deleteSwap($id);
    }

    public function updateSwap(SwapUpdateRequest $request)
    {
        $item = $this->swapManager->updateSwap($request);

        $response = $this->autoMapping->map(SwapEntity::class,SwapsResponse::class, $item);

        return $response;
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