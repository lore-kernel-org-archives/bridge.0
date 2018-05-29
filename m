Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=auDR23PNrmU81Al20ZJpK+zYT9pQa
	OuYAW/DhbAQR20=; b=WwKVeOVo51HAMJy4O7A53f+4vqhxBkS3byhPHalaDCRn8
	V048LPgriCxA6YJRx9iwXf6sH6gQsejwcJ7Lq1YVP6BWji6KGuh7dCGCV/EdghML
	tOUD8uZhKBPKKgYnH7yBVmXawIb0eB0OM2c+tQPtZGi1bvYa1hifV38qSPJp14p9
	GiZqEH0ehWvL69MdE41GcOpe/covoi7Cb1cTfciFWLGXPIGtWZ+hoZpkTY2tSEL3
	WQ7r+BTkafwBnvBrfYDfFnJ51NZFRsi4NSdBZ0VcHnPTJuzaIN4H6KZ5Uk6tkXR6
	N9FRDMqePuLUC2xka5nPDQzLmw1qWidmxtDwhlkkw==
Date: Tue, 29 May 2018 13:58:53 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20180529105853.GA13795@splinter.mtl.com>
References: <cover.1527519997.git.petrm@mellanox.com>
	<20180529104609.jqbql6ts2rbb7k3l@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529104609.jqbql6ts2rbb7k3l@mwanda>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, Petr Machata <petrm@mellanox.com>, davem@davemloft.net

On Tue, May 29, 2018 at 01:46:09PM +0300, Dan Carpenter wrote:
> It occured to me that I should read the cover letter and here are the
> answers I was looking for.  But the cover letter isn't saved after the
> commits are merged.

DaveM adds the cover letter to the merge commit.
