Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=xWqZLEG8FvYVPAWBvuM2luBBRq2trYfk1AOoNRWmB90=;
 b=IRWGN7u/cAur7F5lwRZxEfhuOEow0PvXqoza1SPTP3s/xKa7K5kwYeZjQIgQebSSQWF5
 xnUbigZc2g5HYyYEIU3KjnYAtqsvUHR2zJBDvZ1Ei9QJdVaQmtyWye3rrcNobCkROd+l
 QUX3Tv0Fa+lLY+mbVivI51Zsu7XJVNfPCpgm67kdjVVi8qTX+xeSij9nbfA3K5hj95e8
 CpefX7PxUS/9rnHUxGGQicymPjWPHfM2YD5aNDVnxFXYBsOAGbq2p99DkQHtz5QONrbF
 EFS+Uznf870Bj3r9/QZ/5xvGkSPgJi852xiG2IHdZyhcVBgtVq0roFGneTODzEIfjspw cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwCX9UIc+knuZoIfHMZkDkF3uj4gkic17ZYwY+WTAN8=;
 b=NQu5uVY06rhAn10GLTnM2YVguzWMwnDffcXLxxnxv+zPrUFer8gfxddL9be0ZTgmc1OwrwJ3T/Ij4BiugokeQsiY2bHVtMX2u5NrrsZNCDXp0pu/SNrVGQur5xy6L6NT987U4dgVD/5eCUIfld+FHCyhE5j9DMW5KFha02e902w=
Date: Tue, 16 Nov 2021 11:32:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20211116083237.GH26989@kadam>
References: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
 <20211115123534.GD26989@kadam>
 <b3c93506-7dc8-a5fe-6cfc-938fc88b9f07@wanadoo.fr>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b3c93506-7dc8-a5fe-6cfc-938fc88b9f07@wanadoo.fr>
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

On Mon, Nov 15, 2021 at 07:35:48PM +0100, Christophe JAILLET wrote:
> Le 15/11/2021 =E0 13:35, Dan Carpenter a =E9crit=A0:
> > On Sun, Nov 14, 2021 at 08:02:35PM +0100, Christophe JAILLET wrote:
> > > The 'inuse' bitmap is local to this function. So we can use the
> > > non-atomic '__set_bit()' to save a few cycles.
> > >=20
> > > While at it, also remove some useless {}.
> >=20
> > I like the {} and tend to add it in new code.  There isn't a rule about
> > this one way or the other.
> >=20

[ heavily snipped ]

>=20
> - checkpatch prefers the style without {}

Not for these.

> - Usually, greg k-h and Joe Perches give feed-back that extra {} should be
> removed.

I can't find any reference to that.

> - in https://www.kernel.org/doc/html/v5.13/process/coding-style.html, aft=
er
> "Rationale: K&R":
>    "Do not unnecessarily use braces where a single statement will do."

There are exceptions for readability.  For example, mutiline indents
get it whether they need or not.  Do while statements get braces.

Quite a lot of people don't use braces for list_for_each() unless it's
required, definitely, but I think it's allowable.

regards,
dan carpenter

