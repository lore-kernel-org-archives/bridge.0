Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2017-10-26;
	bh=fa73mUf5LkMSnIdVAgD1rBrH88KuV36tzMfFm6lIGEc=;
	b=twCQpmfJ/s09NI/4jI9FHYxOsVPK+iu32lCRYf1HvdQGV1R/o1jGLjyF/pnLkf1qWaxL
	z07906329wDym3JyYnNgj0aWIZF6Oa6gWddVnZdir3vdMsD5X3TiFHU/wKt8pV8Rh3+6
	w5U5ykn0cxIFbVM9NFl36/hG7uHr8J+0Zkfxz5vJFu57SACJJjFjieDnIEoPeamxngC7
	6bLjDMacm7vhHWMIJGbh03Lllq0hW/ouXR9nHAl+B+WImwvE9OCkb/UMFx584CRz0bdN
	rFny0iuAm625mLMjOUvEoR8Gb+ORn6hglPm0+WpUwCVQRVcnw2a1rQ1RwqNguKngjDtF
	HQ== 
Date: Tue, 29 May 2018 14:02:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180529110206.5daru24uh44owf6i@mwanda>
References: <cover.1527519997.git.petrm@mellanox.com>
	<20180529104609.jqbql6ts2rbb7k3l@mwanda>
	<20180529105853.GA13795@splinter.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529105853.GA13795@splinter.mtl.com>
Subject: Re: [Bridge] [PATCH net-next v3 0/7] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, Petr Machata <petrm@mellanox.com>, davem@davemloft.net

On Tue, May 29, 2018 at 01:58:53PM +0300, Ido Schimmel wrote:
> On Tue, May 29, 2018 at 01:46:09PM +0300, Dan Carpenter wrote:
> > It occured to me that I should read the cover letter and here are the
> > answers I was looking for.  But the cover letter isn't saved after the
> > commits are merged.
> 
> DaveM adds the cover letter to the merge commit.

That's true but it doesn't help.  When I want to find why line of code
is there I look up the commit message, not the merge commit.

regards,
dan carpenter

