<?php


namespace App\Response;


class UserProfileResponse
{
    public $id;

    public $userID;

    public $userName;

    public $location;

    public $story;

    public $image;

    /**
     * @return mixed
     */
    public function getUserName()
    {
        return $this->userName;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }


}