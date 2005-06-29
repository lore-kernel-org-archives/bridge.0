Message-ID: <42C21483.6020702@smartbridges.com>
Date: Wed, 29 Jun 2005 11:24:51 +0800
From: munro <munro.biswal@smartbridges.com>
MIME-Version: 1.0
References: <200506281900.j5SJ06jB009021@smtp.osdl.org>
In-Reply-To: <200506281900.j5SJ06jB009021@smtp.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Bridge Digest, Vol 22, Issue 13
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

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





bridge-request@lists.osdl.org wrote:

>Send Bridge mailing list submissions to
>	bridge@lists.osdl.org
>
>To subscribe or unsubscribe via the World Wide Web, visit
>	http://lists.osdl.org/mailman/listinfo/bridge
>or, via email, send a message with subject or body 'help' to
>	bridge-request@lists.osdl.org
>
>You can reach the person managing the list at
>	bridge-owner@lists.osdl.org
>
>When replying, please edit your Subject line so it is more specific
>than "Re: Contents of Bridge digest..."
>
>
>Today's Topics:
>
>   1. Possibility of  copying over fdb entries.  (munro)
>   2. Re: Possibility of  copying over fdb entries. (Stephen Hemminger)
>
>
>----------------------------------------------------------------------
>
>Message: 1
>Date: Tue, 28 Jun 2005 14:40:34 +0800
>From: munro <munro.biswal@smartbridges.com>
>Subject: [Bridge] Possibility of  copying over fdb entries. 
>To: bridge@lists.osdl.org
>Message-ID: <42C0F0E2.1000501@smartbridges.com>
>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
>
>
>Hi, all,
>
>I wish to copy over fdb(forwarding database  entries) learnt over from 
>one interface  onto  as  they are from another interface.
>
>Like for eg :
> brctl showmacs br0
>port no mac addr                is local?       ageing timer
>  1     00:30:1a:01:6f:e4       no                 0.46
>  1     00:30:1a:1c:3d:b7       yes                0.00
>  2     00:30:1a:1c:3d:b8       yes                0.00
>
>Instead of the above in line 1 if i wish to forcefully add mac  "  
>00:30:1a:01:6f:e4 "  from port 2 instated of port 1.
>
>
>Do i need to create a separate ioctl for it from the brctl to the kernel 
>code or is thier some provision for doing it.
>
>
>Regards,
>Munro.
>
>
>------------------------------
>
>Message: 2
>Date: Tue, 28 Jun 2005 09:48:40 -0700
>From: Stephen Hemminger <shemminger@osdl.org>
>Subject: Re: [Bridge] Possibility of  copying over fdb entries.
>To: munro <munro.biswal@smartbridges.com>
>Cc: bridge@lists.osdl.org
>Message-ID: <20050628094840.6c2e381b@dxpl.pdx.osdl.net>
>Content-Type: text/plain; charset=US-ASCII
>
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
>------------------------------
>
>_______________________________________________
>Bridge mailing list
>Bridge@lists.osdl.org
>http://lists.osdl.org/mailman/listinfo/bridge
>
>
>End of Bridge Digest, Vol 22, Issue 13
>**************************************
>  
>
>------------------------------------------------------------------------
>
>Spam detection software, running on the system "fire-1.osdl.org", has
>identified this incoming email as possible spam.  The original message
>has been attached to this so you can view it (if it isn't spam) or block
>similar future email.  If you have any questions, see
>the administrator of that system for details.
>
>Content preview:  Send Bridge mailing list submissions to
>  bridge@lists.osdl.org To subscribe or unsubscribe via the World Wide
>  Web, visit http://lists.osdl.org/mailman/listinfo/bridge or, via email,
>  send a message with subject or body 'help' to
>  bridge-request@lists.osdl.org [...] 
>
>Content analysis details:   (6.3 points, 5.0 required)
>
> pts rule name              description
>---- ---------------------- --------------------------------------------------
> 1.5 DATE_MISSING           Missing Date: header
> 1.1 NO_REAL_NAME           From: does not include a real name
> 3.7 MSGID_FROM_MTA_SHORT   Message-Id was added by a relay
>
>
>  
>


