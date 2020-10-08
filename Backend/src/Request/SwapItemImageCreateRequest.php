<?php


namespace App\Request;


class SwapItemImageCreateRequest
{
    private $image;

    private $swapItemID;

    private $specialLink;

    /**
     * @return mixed
     */
    public function getSpecialLink()
    {
        return $this->specialLink;
    }

    /**
     * @param mixed $specialLink
     */
    public function setSpecialLink($specialLink): void
    {
        $this->specialLink = $specialLink;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * @return mixed
     */
    public function getSwapItemID()
    {
        return $this->swapItemID;
    }

    /**
     * @param mixed $swapItemID
     */
    public function setSwapItemID($swapItemID): void
    {
        $this->swapItemID = $swapItemID;
    }


}