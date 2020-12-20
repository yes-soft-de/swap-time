<?php

namespace App\Repository;

use App\Entity\SwapItemEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\EventListener\UserListener;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SwapItemEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SwapItemEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SwapItemEntity[]    findAll()
 * @method SwapItemEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SwapItemEntityRepository extends ServiceEntityRepository
{

    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SwapItemEntity::class);
    }

    public function getItems()
    {
        return $this->createQueryBuilder('swapItems')

            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID', 'user.userName as userName', 'swapItems.platform', 'swapItems.specialLink')

            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = swapItems.userID'  //Join Column
            )

            ->orderBy('swapItems.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getItemByID($id)
    {
        return $this->createQueryBuilder('swapItems')
            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID', 'user.userName as userName', 'swapItems.platform', 'swapItems.specialLink')

            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = swapItems.userID'  //Join Column
            )

            ->andWhere('swapItems.id=:id')
            ->setParameter('id', $id)

            ->groupBy('swapItems.id')
            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getItemByUserID($userID)
    {
        return $this->createQueryBuilder('swapItems')
            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID', 'user.userName as userName', 'swapItems.platform', 'swapItems.specialLink')

            ->leftJoin(
                UserProfileEntity::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = swapItems.userID'  //Join Column
            )

            ->andWhere()
            ->andWhere('swapItems.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }
}
