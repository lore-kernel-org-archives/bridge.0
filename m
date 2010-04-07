Date: Wed, 7 Apr 2010 09:31:07 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100407093107.7edac11c@nehalam>
In-Reply-To: <r2ocfeab66d1004070304w85b4c592h59dd01fa344d9fbc@mail.gmail.com>
References: <r2ocfeab66d1004070304w85b4c592h59dd01fa344d9fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] queing layer and bridge traffic .
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 7 Apr 2010 15:34:08 +0530
ratheesh k <ratheesh.ksz@gmail.com> wrote:

> Hi ,
> 
> I know that netif_receive_skb()  and dev_queue_xmit()  are enty and
> exit function queing layer of linux ip stack . I believe these
> functions are called only for ip packets ( not for frames ) . Am i
> right here ?

These work at Ethernet packet level.  Not at IP level.

> My question : Whether these functions are invloved in any brigde
> function ( frames ) ?

Reading the code is best.  Bridging is invoked in netif_receive_skb
by the hook function.

> Thanks,
> Ratheesh
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


-- 
