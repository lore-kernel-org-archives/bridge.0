Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] bridge MAC address
Date: Fri, 3 Mar 2006 10:03:04 +0200
Message-ID: <37A954DFE3784244A7831AF8412790B5D18ECF@zil01exm61.ds.mot.com>
From: "Levi Ariel-BAL023" <ariel.levi@motorola.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


Stephen,

Thanks for your quick respond.

What do you mean by "later kernels"? I curently use kernel 2.4.20
Can I add a ioctl that enables modifying the bridge MAC address?

Thanks,
  Ariel


-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org] 
Sent: Thursday, March 02, 2006 10:31 PM
To: Levi Ariel-BAL023
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] bridge MAC address

On Thu, 2 Mar 2006 20:20:38 +0200
"Levi Ariel-BAL023" <ariel.levi@motorola.com> wrote:

> Hi,
> 
>  
> 
> I have notice that the bridge gets the "lowest" MAC address of its 
> interfaces.
> 
> Function: br_stp_recalculate_bridge_id()
> 
>  
> 
> Is there a meaning behind this or not?
> 
>  
> 
> Thanks,
> 
>  Ariel
> 

It's part of the Spanning Tree Protocol in the 802.1d standard.
In later kernels you can reset the address to be the same as any
of the interfaces being bridged.

