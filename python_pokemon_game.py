import random

class PocketMaster:
    
    def __init__(self,name,hp,attack,defense):
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
        
    def describe(self):
        return  str(self.name) + " (HP = "+ str(self.hp) + ")"
    
    def hit(self,PocketMaster):
            
        randomAttack = random.randint(0,self.attack)
        randomDefense = random.randint(0,PocketMaster.defense)
        
        if randomAttack > randomDefense:
            PocketMaster.hp -= randomAttack - randomDefense
            return self.name+ " uses attack on " + PocketMaster.name +"\n" + "It's effective!"+ "\n" + str(self.describe())+ " vs " + str(PocketMaster.name) + " (HP= "+str(PocketMaster.hp) + ")"
    
        else:
            PocketMaster.hp == PocketMaster.hp
            return self.name+ " uses attack on " + PocketMaster.name +"\n" + "It's not very effective..." + "\n"+ str(self.describe())+ " vs " + str(PocketMaster.name) + " (HP= "+str(PocketMaster.hp) + ")"
        
    
    
       
    def dead(self):
        
        if self.hp <= 0:
            return True
        else:
            return False
        
        
    
    
        
        
pika = PocketMaster("Pikachu",10,10,5)
mudkip = PocketMaster("Mudkip",8,12,4)


while True:
    print(pika.describe(), "vs" ,mudkip.describe())
    print(pika.hit(mudkip))
    if mudkip.dead():
        break
    print(mudkip.hit(pika))
    if pika.dead():
        break

print("battle is over")

        

