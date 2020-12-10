<?php


namespace App\Response;


class SwapItemsResponse
{
    public $id;

    public $name;

    public $category;

    public $platform;

    public $tag = [];

    public $description;

    public $mainImage;

    public $userID;

    public $userName;

    public $commentNumber;

    public $interaction;

    public $comments;

    public $images;

    public $specialLink;

    public $isRequested;

    /**
     * @return mixed
     */
    public function getMainImage()
    {
        return $this->mainImage;
    }


}