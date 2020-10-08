<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Manager\ImageManager;
use App\Response\ImageResponse;
use App\Response\SwapItemImageCreateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ImageService
{
    private $autoMapping;
    private $imageManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, ImageManager $imageManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->params = $params->get('upload_base_url').'/';;
    }

    public function imageCreate($request)
    {
        $imageCreate = $this->imageManager->imageCreate($request);

        return $this->autoMapping->map(ImageEntity::class,SwapItemImageCreateResponse::class, $imageCreate);
    }

    public function getImages($id)
    {
        $imagesResponse = [];

        $images = $this->imageManager->getImages($id);

        foreach ($images as $image)
        {
            $image['image']= $this->specialLinkCheck($image['specialLink']).$image['image'];
            $imagesResponse[] = $this->autoMapping->map('array', ImageResponse::class, $image);
        }

        return $imagesResponse;
    }

    public function specialLinkCheck($bool)
    {
        if ($bool == false)
        {
            return $this->params;
        }
    }
}