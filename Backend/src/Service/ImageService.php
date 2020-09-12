<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Manager\ImageManager;
use App\Response\ImageResponse;
use App\Response\SwapItemImageCreateResponse;

class ImageService
{
    private $autoMapping;
    private $imageManager;

    public function __construct(AutoMapping $autoMapping, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
    }

    public function imageCreate($request)
    {
        $imageCreate = $this->imageManager->imageCreate($request);

        $response = $this->autoMapping->map(ImageEntity::class,SwapItemImageCreateResponse::class, $imageCreate);

        return $response;
    }

    public function getImages($id)
    {
        $imagesResponse = [];

        $images = $this->imageManager->getImages($id);

        foreach ($images as $image)
        {
            $imagesResponse[] = $this->autoMapping->map('array', ImageResponse::class, $image);
        }

        return $imagesResponse;
    }
}