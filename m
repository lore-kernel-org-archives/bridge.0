Date: Mon, 13 Apr 2009 23:04:31 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090413230431.50d58d61@nehalam>
In-Reply-To: <E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
	<20090413080009.034a5e7f@nehalam>
	<E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Out of memory problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tekale Sharad-FHJN78 <FHJN78@motorola.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 14 Apr 2009 13:21:13 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

>  
> 
> Hi Stephen 
> > Most likely, you have created a loop and are not running spanning
> tree. When a loop happens, packets multiply until all > resources are
> exhausted.
> 
> > you have created a loop.
> Ya, I have bridge named br-lan created by($brctl), and I have attached
> two interfaces to it, and I'm sending traffic from PC1 to PC2. Some
> thing like this
> 
>  	    		 ----------------------- 
> 	   		|    ------------       |
> 	   		|   |   br-lan   |      |    <--- AP
> 	   		|    ------------       |      
> 	   		|  eth0.0       eth0.1  | 
> 	    		 ----|------------|-----
> 
> 	      	     |	      |
> 	      	     |	      |
>   	     		    PC1          PC2
> 
> Previously:
> root@none:/$ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br-lan          8000.001570d8d8fd       no              eth0.0
>                                                         eth0.1
> 
> >are not running spanning tree.
> Is it always necessary to enable spanning tree when traffic is sent over
> loop?
> 
> I have enabled spanning tree using
> 
> root@none:/$ brctl stp br-lan on
> root@none:/$ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br-lan          8000.001570d8d8fd       yes             eth0.0
>                                                         eth0.1
> 
> But again, when huge traffic is pumped from PC1 to PC2, The
> skbuff_head_cache value is increased rapidly and even after stop pumping
> the traffic, this value doesn't come down, and system goes for crash or
> reboot because of out of memory.
> 
> root@none:/$ cat /proc/slabinfo | grep skbuff_head
> skbuff_head_cache   4560   4560    192   20    1 : tunables  120   60
> 0 : slabdata    228    228      0
> 
> One more point, say I have each port attached to there own bridge, and
> when I route traffic from one host to other, I'll not face this
> behavior, This behavior is relevant only in above case.
> 
> Do I have to do any other setting to overcome out of memory problem? 
> Also, Please let me know if any other information is required to isolate
> this behavior.

What network device driver, that is probably the problem?
