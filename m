Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Rfy7/PoE01BBgCAK3Z9KK5eQGQYEaFHqiVsEnkn6FAg=;
 b=hZLYCI6VPjVLsIBTKclsSbry4RhJzisSWeXrtLQ5W2XNAxmXFRQBTwz7bfniH3FsFGXZ
 9CoqU7d0CE5mQO/4MddkSDzZT+58YQdVwYV7/02naB9inY6edQBjJePVubEnlLD/xqpJ
 XPB19MblGFJS4AgKnv7cHo0LvuAB0GNzvFMGBjVzj4/ay3XsXfh8grKpveyE0uAXFZLw
 p9n+YdPVLH6I0akfSYzHMcSweZUpTWFUS3dxTvJnQZrgaPDDEA0/qfe+zrxaH9arKHfu
 sXgXqkLsmKGNhvOQoCFIID0p/yh6hPZy7OC93TO70eWQP0j3kxPunIq413rdISoQDduv qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfy7/PoE01BBgCAK3Z9KK5eQGQYEaFHqiVsEnkn6FAg=;
 b=FUTAdXKarJAqvuY6W3UDy3KF/DlB173kWrPFecseIjxdglYYVe+AZrAhCtO1dtKahLCsNBUJ46aqeeph8gci9IJwRlPdEqFTnM7mGlV3g0+yzwPMFNdKlHhMYePc7MiWGJWkyflqO3vwy4xemXPF+esd1Sr8pyMj0wX0EX+v7Kk=
Date: Mon, 15 Nov 2021 15:35:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20211115123534.GD26989@kadam>
References: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net: bridge: Slightly optimize 'find_portno()'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Sun, Nov 14, 2021 at 08:02:35PM +0100, Christophe JAILLET wrote:
> The 'inuse' bitmap is local to this function. So we can use the
> non-atomic '__set_bit()' to save a few cycles.
> 
> While at it, also remove some useless {}.

I like the {} and tend to add it in new code.  There isn't a rule about
this one way or the other.

regards,
dan carpenter


