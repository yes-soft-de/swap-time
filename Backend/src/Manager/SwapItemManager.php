<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\SwapItemEntity;
use App\Repository\SwapItemEntityRepository;
use App\Request\SwapItemCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class SwapItemManager
{
    private $autoMapping;
    private $entityManager;
    private $swapItemEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SwapItemEntityRepository $swapItemEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->swapItemEntityRepository = $swapItemEntityRepository;
    }

    public function swapItemCreate(SwapItemCreateRequest $request)
    {
        $item = $this->autoMapping->map(SwapItemCreateRequest::class, SwapItemEntity::class, $request);

        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function getSwapItems()
    {
        return $this->swapItemEntityRepository->getItems();
    }

    public function getSwapItemByID($id)
    {
        return$this->swapItemEntityRepository->getItemByID($id);
    }

    public function getSwapItemByUserID($userID)
    {
        return $this->swapItemEntityRepository->getItemByUserID($userID);
    }
}