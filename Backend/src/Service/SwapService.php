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

class SwapService
{
    private $autoMapping;
    private $swapManager;

    public function __construct(AutoMapping $autoMapping, SwapManager $swapManager)
    {
        $this->autoMapping = $autoMapping;
        $this->swapManager = $swapManager;
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
            $itemsResponse[] = $this->autoMapping->map('array', SwapsResponse::class, $item);
        }

        return $itemsResponse;
    }
}