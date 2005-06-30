Message-ID: <42C354C0.1030307@smartbridges.com>
Date: Thu, 30 Jun 2005 10:11:12 +0800
From: munro <munro.biswal@smartbridges.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Possibility of  copying over fdb entries.
References: <42C0F0E2.1000501@smartbridges.com>	<20050628094840.6c2e381b@dxpl.pdx.osdl.net>	<42C21887.70006@smartbridges.com>
	<20050629141152.119f28f2@dxpl.pdx.osdl.net>
In-Reply-To: <20050629141152.119f28f2@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

How would it cause a loop. what i am trying is to possibly prevent a 
loop without using stp.

And Please let me know how bonding will help. I am a newbie in this arena.

regards



Stephen Hemminger wrote:

>On Wed, 29 Jun 2005 11:41:59 +0800
>munro <munro.biswal@smartbridges.com> wrote:
>
>  
>
>>Hi,
>>
>>What is wish to do is
>>There are four interfaces here
>>
>>              PC1---------------------| br0 
>>|if0-------------------if2|   br1 | ----------------------PC2
>>                                         |        
>>|if1------------------- if3|         |
>>
>>
>>br0 and br1- are two transperent bridges on separate devices.
>>if0 and if1 are two physical interfaces(ports) attached to each of the 
>>bridges on  either side.
>>
>>What i intend to do is to redirect all traffic coming  towards  br0  
>>from PC1 through interface/port if1,  even if the source mac is learnt 
>>through if0 and the same on the other bridge br1 on the other device.  
>>Similarly, any traffic  coming from PC2  has to go through if2 instead 
>>of if3 before it enters br0. So in all, what i want to do is make the 
>>link from  br0 to br1 full duplex if the physical links are half-duplex.
>>
>>Regards,
>>Munro.
>>    
>>
>
>That would create a possible loop if the links are full duplex, and that
>would be a disaster!  Maybe you could do what you want with the bonding
>interface?
>  
>


