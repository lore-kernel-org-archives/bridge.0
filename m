Date: Wed, 23 Apr 2008 10:43:40 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080423104340.2416280e@extreme>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA1E1@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32FA1E1@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Getting statistics from a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.linux-foundation.org

On Wed, 23 Apr 2008 10:53:12 +1000
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All,
>  Is there any way of getting detailed statistics from a bridge?
> Specifically, I need to know how many frames may have been dropped
> because they exceed the MTU of the underlying port. I'm having a few
> issues with MTUs not agreeing.
>  
> Regards,
>              Leigh
>  

It would not be hard to modify kernel to use one of the existing statistics on
the bridge interface to keep track of the dropped packets. I'll look into it
if no one else gets to it first (hint, hint)

