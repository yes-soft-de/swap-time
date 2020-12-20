<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Repository\ImageEntityRepository;
use App\Request\SwapItemImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ImageManager
{
    private $autoMapping;
    private $entityManager;
    private $imageEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ImageEntityRepository $imageEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->imageEntityRepository = $imageEntityRepository;
    }

    public function imageCreate(SwapItemImageCreateRequest $request)
    {
        $imageCreate = $this->autoMapping->map(SwapItemImageCreateRequest::class, ImageEntity::class, $request);

        $this->entityManager->persist($imageCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $imageCreate;
    }

    public function getImages($id)
    {
        return $this->imageEntityRepository->getSwapItemImages($id);
    }
}