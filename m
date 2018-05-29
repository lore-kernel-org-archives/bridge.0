Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2017-10-26;
	bh=1G2QQO+OuBCqo4xhLNHJGVPoCvb4YZKa0BTheN9WXQg=;
	b=BBKfs5IBVW4bZwoYcxvXDxT68z9tYzI1USmQq8+auJv3cx5bFFD/vWWc1CeP+8FyTx9q
	xQB/PD9KPjxUtssr+xkgQI18l62hUBOkJHxyxVNFiRLonYslTk2CXI18xgcMLWfOPXdx
	p2XORAkPQ52rN6XacJD+jZPLL37EhlIFHxLRqfEZQIH/7Zh1S2OdSDcz0XDAJcLPgxDk
	+1A/om70mS34OhfAAGE9ikkZcNOM3r12fsdyZUyxQACeeLFSg57hmBOGXW2zHbRAauNr
	GklsOiHDebkqBFa4of6ijvbJ5jEcvx5Ere/uq6rXw153YewRgjbca2dktDOPfLr+jL0J
	LA== 
Date: Tue, 29 May 2018 13:43:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180529104303.ycybyk73ynaohzhi@mwanda>
References: <cover.1527519997.git.petrm@mellanox.com>
	<67c3f567cd774cae8935873072c81e5ea62dc521.1527519997.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c3f567cd774cae8935873072c81e5ea62dc521.1527519997.git.petrm@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next v3 2/7] mlxsw: spectrum_switchdev:
 Ignore bridge VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

On Mon, May 28, 2018 at 05:10:40PM +0200, Petr Machata wrote:
> Ignore VLAN events where the orig_dev is the bridge device itself.
> 

I don't know this code, and I have not looked at it either...  But this
changelog just says what you are doing and not why.  Is this a bug fix?
What are the user visible effects of this patch?  Perhaps it is
something which will be required in the future but has no effect now?

You know how the New York Times is written for people with at least a
10th grade education?  I feel like maybe if I knew this code I would
know the answers to my question, but kernel commit descriptions should
generally be written to Dan Carpenter level of education.  Which is
pretty darn ignorant...  Can you please resend?

regards,
dan carpenter


