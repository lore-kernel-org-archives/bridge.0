Message-ID: <45686B94.60308@purdue.edu>
Date: Sat, 25 Nov 2006 11:13:08 -0500
From: Roman Chertov <rchertov@purdue.edu>
MIME-Version: 1.0
References: <45685fc1.97.fad.217423974@webh4.fe.aruba.it>
In-Reply-To: <45685fc1.97.fad.217423974@webh4.fe.aruba.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: fulvio.ricciardi@zeroshell.net
Cc: bridge@lists.osdl.org

Unless you have Gigabit with jumbo frames you cannot send a packet 
larger than 1500bytes because this is the Maximum Transmission Unit (MTU).

Roman

Fulvio Ricciardi wrote:
> Hi,
> I noticed the same problem with the kernel 2.6.16.21 but I
> didn't try with newer kernel.
> 
> 
>> Hi
>>  
>>  I have some problem with passing vlan tagged packets
>> through linux bridge.
>>  In the linux box eth0 , eth1  are add to br0 and the
>> bridge is up and working correctly. 
>>  I 've connected eth0 to trunk port of switch A and eth1
>> to trunk port of switch B.
>>  port 1,2,3 of each switch are in vlan 1. I've 2 client in
>> the same subnet , client A connected to port 1 of switch A
>> and client B connected to port 1 of switch . the problem
>> is when I ping client A from clinet B or viceversa ,I
>> can't ping with more than 1470bytes packet size!
>>  ping will work fine by 1470byte packet size but ping with
>> more than 1470bytes packet size will fail.
>>  any idea??
>>  
>>  KasrA
>>  
>>  
>> ---------------------------------
>> Check out the all-new Yahoo! Mail beta - Fire up a more
>> powerful email and get things done faster.
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.osdl.org
>> https://lists.osdl.org/mailman/listinfo/bridge
>>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
> 

