Return-Path: <Ian.Campbell@citrix.com>
Message-ID: <1367331842.3142.546.camel@zakaz.uk.xensource.com>
From: Ian Campbell <Ian.Campbell@citrix.com>
Date: Tue, 30 Apr 2013 15:24:02 +0100
In-Reply-To: <1367232145.26060.1.camel@yuval-pc>
References: <5757e54b-902b-4338-8ac9-43857cd1906c@default>
	<50FD8243.6000501@oracle.com>
	<1358846612.3279.282.camel@zakaz.uk.xensource.com>
	<201301291054.46405.yuval.shaia@oracle.com>
	<1359455385.12252.85.camel@zakaz.uk.xensource.com>
	<1367232145.26060.1.camel@yuval-pc>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Add support for netconsole driver used on
 bridge device with VIF attached
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@vyatta.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Mon, 2013-04-29 at 11:42 +0100, Yuval Shaia wrote:
> Can you suggest how to continue from here? as i don't see any comment on
> that issue up to now.

Please can you resend the patch with an extended changelog based on the
discussions in this thread and CC the bridge folks as well.

Ian.

> Yuval
> > 
> > AFAICT the only reason to actually support netpoll in netback would be
> > if you wanted host logs to go to a listener running in a domain on the
> > same host, which sounds like a mad idea to me! If someone actually has a
> > real need for that use case and can test that it works I'd be happy to
> > reconsider this patch on that basis (assuming the necessary #ifdefs are
> > added as mentioned before).
> > 
> > > > BTW looking at the patch as it is any use of this hook should be wrapped
> > > > in CONFIG_NET_POLL_CONTROLLER.
> > > > 
> > > > Ian.
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 
> 


