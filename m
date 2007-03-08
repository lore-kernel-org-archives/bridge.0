Date: Thu, 8 Mar 2007 13:14:25 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070308131425.3f31c811@freekitty>
In-Reply-To: <DE026503646E7F40AF97BAB98334333B267A1B@uss-republic.finepoint.com>
References: <20070307160355.0e27f425@dxpl.pdx.osdl.net>
	<DE026503646E7F40AF97BAB98334333B267A1B@uss-republic.finepoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] brctl issue
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <hwang@finepoint.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

On Wed, 7 Mar 2007 22:30:09 -0500
"Hai Wang" <hwang@finepoint.com> wrote:

> Hello,
>  
>      I have a question regarding brctl and br2684, I have a network scenrio where I have to add br2684-rt into a bridge. but I could not do so with brctl, please let me if you have any suggestion on the issue.
>  
> My scenario :
>  
>                                        (vpi/vci) 
>       192.168.2.16             0/32               nas0
>     DSLAM1 (BR2684-rt)  --------------|-----------------
>        192.168.3.26            0/33                |                         |                                    192.168.1.18
>     DSLAM 2(BR2684-rt)  --------------| nas1 (LINUX)  Eth0     -----------------PC1 (OAM)
>         192.168.4.36            0/34               |                         |
>     DSLAM 3(BR2684-rt)  --------------|nas2------------
>  
>  
>     I want to put nas0, nas1, nas2 and eth0 on a bridge so that PC1 is able to communicate with DSLAMS.
>  
>  
>   Note that we do not want to assign any IP on nas0, nas1 and nas2.
>  
>  
> Please help with your suggestion.
>  

There is support for ATM bridging but never tried it (don't have ATM)
Did you look at?

	http://home.regit.org/?page_id=8
-- 
Stephen Hemminger <shemminger@linux-foundation.org>
