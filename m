Message-ID: <42C21887.70006@smartbridges.com>
Date: Wed, 29 Jun 2005 11:41:59 +0800
From: munro <munro.biswal@smartbridges.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Possibility of  copying over fdb entries.
References: <42C0F0E2.1000501@smartbridges.com>
	<20050628094840.6c2e381b@dxpl.pdx.osdl.net>
In-Reply-To: <20050628094840.6c2e381b@dxpl.pdx.osdl.net>
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
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Hi,

What is wish to do is
There are four interfaces here

              PC1---------------------| br0 
|if0-------------------if2|   br1 | ----------------------PC2
                                         |        
|if1------------------- if3|         |


br0 and br1- are two transperent bridges on separate devices.
if0 and if1 are two physical interfaces(ports) attached to each of the 
bridges on  either side.

What i intend to do is to redirect all traffic coming  towards  br0  
from PC1 through interface/port if1,  even if the source mac is learnt 
through if0 and the same on the other bridge br1 on the other device.  
Similarly, any traffic  coming from PC2  has to go through if2 instead 
of if3 before it enters br0. So in all, what i want to do is make the 
link from  br0 to br1 full duplex if the physical links are half-duplex.

Regards,
Munro.


Stephen Hemminger wrote:

>On Tue, 28 Jun 2005 14:40:34 +0800
>munro <munro.biswal@smartbridges.com> wrote:
>
>  
>
>>Hi, all,
>>
>>I wish to copy over fdb(forwarding database  entries) learnt over from 
>>one interface  onto  as  they are from another interface.
>>
>>Like for eg :
>> brctl showmacs br0
>>port no mac addr                is local?       ageing timer
>>  1     00:30:1a:01:6f:e4       no                 0.46
>>  1     00:30:1a:1c:3d:b7       yes                0.00
>>  2     00:30:1a:1c:3d:b8       yes                0.00
>>
>>Instead of the above in line 1 if i wish to forcefully add mac  "  
>>00:30:1a:01:6f:e4 "  from port 2 instated of port 1.
>>    
>>
>
>Why? What reason.
>
>  
>
>>Do i need to create a separate ioctl for it from the brctl to the kernel 
>>code or is thier some provision for doing it.
>>    
>>
>
>Since all enhancements can be 2.6 only,
>I would prefer a sysfs interface to an ioctl to do this.
>You can add a store/write interface to /sys/class/net/brX/bridge/brforward
>file.  The creative part is figuring out what the semantics should
>be and getting the locking right.
>  
>


