<?php


namespace App\Response;


class SwapsResponse
{
    public $id;

    public $date;

    public $userIdOne;

    public $userOneName;

    public $userOneImage;

    public $userTwoName;

    public $userTwoImage;

    public $userIdTwo;

    public $swapItemIdOne;

    public $swapItemOneImage;

    public $swapItemIdTwo;

    public $swapItemTwoImage;

    public $cost;

    public $roomID;

    public $status;

    public function getUserIdOne()
    {
        return $this->userIdOne;
    }

    public function getUserIdTwo()
    {
        return $this->userIdTwo;
    }

    public function getSwapItemIdOne()
    {
        return $this->swapItemIdOne;
    }

    public function getSwapItemIdTwo()
    {
        return $this->swapItemIdTwo;
    }

    /**
     * @param mixed $userOneName
     */
    public function setUserOneName($userOneName): void
    {
        $this->userOneName = $userOneName;
    }

    /**
     * @param mixed $userOneImage
     */
    public function setUserOneImage($userOneImage): void
    {
        $this->userOneImage = $userOneImage;
    }

    /**
     * @param mixed $userTwoName
     */
    public function setUserTwoName($userTwoName): void
    {
        $this->userTwoName = $userTwoName;
    }

    /**
     * @param mixed $userTwoImage
     */
    public function setUserTwoImage($userTwoImage): void
    {
        $this->userTwoImage = $userTwoImage;
    }

    /**
     * @param mixed $userIdTwo
     */
    public function setUserIdTwo($userIdTwo): void
    {
        $this->userIdTwo = $userIdTwo;
    }

    /**
     * @param mixed $swapItemOneImage
     */
    public function setSwapItemOneImage($swapItemOneImage): void
    {
        $this->swapItemOneImage = $swapItemOneImage;
    }

    /**
     * @param mixed $swapItemTwoImage
     */
    public function setSwapItemTwoImage($swapItemTwoImage): void
    {
        $this->swapItemTwoImage = $swapItemTwoImage;
    }

    
}