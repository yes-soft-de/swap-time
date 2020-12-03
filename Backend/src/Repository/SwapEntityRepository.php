<?php

namespace App\Repository;

use App\Entity\SwapEntity;
use App\Entity\SwapItemEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SwapEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SwapEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SwapEntity[]    findAll()
 * @method SwapEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SwapEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SwapEntity::class);
    }

    public function getItems()
    {
        return $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'swap.userIdTwo', 'swap.swapItemIdOne',
                'swap.swapItemIdTwo', 'swap.cost', 'swap.roomID', 'swap.status')

            ->orderBy('swap.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getItemByID($id)
    {
        $r =  $this->createQueryBuilder('swap')

            ->andWhere('swap.id=:id')
            ->setParameter('id', $id)

            ->getQuery()
           ->getOneOrNullResult();

        return $r;
    }

    public function getItemByUserID($userID)
    {
        $r =  $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'userOne.userName as userOneName','userTwo.userName as userTwoName',
                'swap.userIdTwo', 'swap.swapItemIdOne', 'userOne.image as userOneImage', 'userTwo.image as userTwoImage',
                'swap.swapItemIdTwo','swapItemOne.mainImage as swapItemOneImage','swapItemTwo.mainImage as swapItemTwoImage',
                'swap.cost', 'swap.roomID', 'swap.status', 'swapItemOne.specialLink as itemOneSpecialImage', 'swapItemTwo.specialLink as itemTwoSpecialImage')

            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'userOne',                        //Alias
                Join::WITH,              //Join Type
                'userOne.userID = swap.userIdOne'  //Join Column
            )
            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'userTwo',                        //Alias
                Join::WITH,              //Join Type
                'userTwo.userID = swap.userIdTwo'  //Join Column
            )

            ->leftJoin(
                SwapItemEntity::class,              //Entity
                'swapItemOne',                        //Alias
                Join::WITH,              //Join Type
                'swapItemOne.id = swap.swapItemIdOne'  //Join Column
            )
            ->leftJoin(
                SwapItemEntity::class,              //Entity
                'swapItemTwo',                        //Alias
                Join::WITH,              //Join Type
                'swapItemTwo.id = swap.swapItemIdTwo'  //Join Column
            )

            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('userID', $userID)
            ->orWhere('swap.userIdTwo=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();

        return $r;
    }

    public function getSwapByItemAndUserID($userID, $itemID)
    {
        $r =  $this->createQueryBuilder('swap')

            ->andWhere('swap.swapItemIdOne=:itemID')
            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('itemID', $itemID)
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();

        return $r;
    }
}
