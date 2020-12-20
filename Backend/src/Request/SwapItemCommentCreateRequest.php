<?php


namespace App\Request;


use DateTime;

class SwapItemCommentCreateRequest
{
    private $comment;

    private $date;

    private $userID;

    private $swapItemID;

    /**
     * @return mixed
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * @param mixed $comment
     */
    public function setComment($comment): void
    {
        $this->comment = $comment;
    }

    public function getDate():?\DateTime
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    public function setDate(\DateTime $date): self
    {
        try
        {
            $this->date = new \DateTime((string)$date);
        }
        catch (\Exception $e)
        {
        }

        return $this;
    }

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
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