Message-ID: <41DBF568.8040703@phreaker.net>
Date: Wed, 05 Jan 2005 22:10:48 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Neighbour table overflow
References: <41DAD4CD.7040606@softhome.net>	<1104872660.3376.11.camel@localhost.localdomain>
	<41DB378A.30309@phreaker.net>
In-Reply-To: <41DB378A.30309@phreaker.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Based on the result of the command "brctl showstp br0" below, what is 
the "designated bridge" means?

Something strange on this line "designated bridge      
8000.000e6ae78720", this is because this is the MAC address of my 3Com 
4400 switch which I have VLAN running and bridge too...

Will this cause the problem?

root@fw01:~# brctl showstp br0
br0
 bridge id              8000.000c4120c1a6
 designated root        8000.000bac2851c0
 root port                 2                    path cost                136
 max age                  20.00                 bridge max 
age            20.00
 hello time                2.00                 bridge hello 
time          2.00
 forward delay            15.00                 bridge forward 
delay      15.00
 ageing time             300.00
 hello timer               0.00                 tcn 
timer                  0.00
 topology change timer     0.00                 gc 
timer                   0.90
 flags


eth0 (1)
 port id                8001                    state                
forwarding
 designated root        8000.000bac2851c0       path cost                100
 designated bridge      8000.000c4120c1a6       message age 
timer          0.00
 designated port        8001                    forward delay 
timer        0.00
 designated cost         136                    hold 
timer                 0.00
 flags

eth5 (2)
 port id                8002                    state                
forwarding
 designated root        8000.000bac2851c0       path cost                100
 designated bridge      8000.000e6ae78720       message age 
timer          3.08
 designated port        800d                    forward delay 
timer        0.00
 designated cost          36                    hold 
timer                 0.00
 flags


ro0ot wrote:

> I had this line for the br0 IP address: -
>
> ifconfig br0 192.168.1.1 netmask 255.255.255.0 broadcast 192.168.1.255
>
> Regards,
> ro0ot
>
>
> Bart De Schuymer wrote:
>
>> Op wo, 05-01-2005 te 01:39 +0800, schreef WL Siew:
>>  
>>
>>> Hi,
>>>
>>> I had successfully setup my bridge (br0) but after few minutes the 
>>> br0 interface seems not working.
>>>
>>> ifconfig eth0 0.0.0.0
>>> ifconfig eth5 0.0.0.0
>>>
>>> brctl addbr br0
>>>
>>> brctl addif br0 eth0
>>> brctl addif br0 eth5
>>>
>>> brctl stp br0 on
>>>   
>>
>>
>>> From the information you give, it seems that you assigned the IP 
>>> address
>>
>> 0.0.0.0 to your bridge ports and you didn't to start the bridge itself.
>> Your box therefore has no IP address and will therefore not respond to
>> icmp messages.
>>
>> Try
>> # ifconfig br0 $IP_ADDRESS
>> A ping to $IP_ADDRESS from another host should then work (after you
>> start the bridge it can take a few seconds before the bridge responds).
>>
>>  
>>
>>> I check on my system's /var/log/syslog file.  It shows something 
>>> strange messages as below: -
>>>
>>> Jan  2 10:44:22 fw01 kernel: ipt_tcpmss_target: bad length (64 bytes)
>>> Jan  2 10:44:32 fw01 last message repeated 11 times
>>> Jan  2 12:27:08 fw01 kernel: Neighbour table overflow.
>>> Jan  2 12:27:11 fw01 last message repeated 9 times
>>> Jan  2 12:27:13 fw01 kernel: NET: 10 messages suppressed.
>>>   
>>
>>
>> Perhaps these are triggered by the fact that your network devices enter
>> promiscuous mode.
>>
>>  
>>
>>> I unplug the network cable connected to the eth5 and run a ping to 
>>> my router...the network is up again...I am able to ping my router.
>>>   
>>
>>
>> I'm assuming you are talking about the bridge box when you are talking
>> about the router? The bridge ports of a bridge are by default not
>> separately pingable. Only the IP address of the bridge (br0) device
>> itself is pingable.
>> You can change that behaviour by making a brouter. You can then assign
>> IP addresses to the bridge ports and use them.
>>
>> cheers,
>> Bart
>>
>>
>>
>>  
>>
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
>



