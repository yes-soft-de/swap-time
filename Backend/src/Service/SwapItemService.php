<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\SwapItemEntity;
use App\Manager\SwapItemManager;
use App\Request\SwapItemCreateRequest;
use App\Response\SwapItemCreateResponse;
use App\Response\SwapItemsResponse;

class SwapItemService
{
    private $autoMapping;
    private $swapItemManager;

    public function __construct(AutoMapping $autoMapping, SwapItemManager $swapItemManager)
    {
        $this->autoMapping = $autoMapping;
        $this->swapItemManager = $swapItemManager;
    }

    public function swapItemCreate(SwapItemCreateRequest $request)
    {
        $item = $this->swapItemManager->swapItemCreate($request);

        $response = $this->autoMapping->map(SwapItemEntity::class,SwapItemCreateResponse::class, $item);

        return $response;
    }

    public function getSwapItems()
    {
        $itemsResponse = [];
        $items = $this->swapItemManager->getSwapItems();

        foreach ($items as $item)
        {
            $itemsResponse[] = $this->autoMapping->map('array', SwapItemsResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getSwapItemByID($id)
    {
        $item = $this->swapItemManager->getSwapItemByID($id);

        $itemsResponse = $this->autoMapping->map('array', SwapItemsResponse::class, $item);

        return $itemsResponse;
    }

    public function getSwapItemByUserID($userID)
    {
        $itemsResponse = [];
        $items = $this->swapItemManager->getSwapItemByUserID($userID);

        foreach ($items as $item)
        {
            $itemsResponse[] = $this->autoMapping->map('array', SwapItemsResponse::class, $item);
        }

        return $itemsResponse;
    }
}