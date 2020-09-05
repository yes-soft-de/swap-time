<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\SwapEntity;
use App\Repository\SwapEntityRepository;
use App\Request\SwapCreateRequest;
use App\Request\SwapUpdateRequest;
use App\Response\SwapsResponse;
use Doctrine\ORM\EntityManagerInterface;

class SwapManager
{
    private $autoMapping;
    private $entityManager;
    private $swapEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SwapEntityRepository $swapEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->swapEntityRepository = $swapEntityRepository;
    }

    public function swapCreate(SwapCreateRequest $request)
    {
        $item = $this->autoMapping->map(SwapCreateRequest::class, SwapEntity::class, $request);
        $item->setDate($request->getDate());

        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function getSwaps()
    {
        return $this->swapEntityRepository->getItems();
    }

    public function getSwapByID($id)
    {
        return $this->swapEntityRepository->getItemByID($id);
    }

    public function deleteSwap($id)
    {
        $item = $this->swapEntityRepository->getItemByID($id);

        if ($item)
        {
            $this->entityManager->remove($item);
            $this->entityManager->flush();

            return $id;
        }
    }

    public function updateSwap(SwapUpdateRequest $request)
    {

        $item = $this->swapEntityRepository->getItemByID($request->getId());

        if ($item)
        {
            $item = $this->autoMapping->mapToObject(SwapUpdateRequest::class,
                SwapEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getSwapsByUserID($userID)
    {
        return $this->swapEntityRepository->getItemByUserID($userID);
    }
}