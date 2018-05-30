Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=M8we5sD8tZkdHqbRjz3tnh7kVrTM5RNszhhETjdcXE0=;
	b=dqIOtkTjFjDFjJLv3+YqyB/6HPzfaH3mZMkTxqP95pXKKhG5WsIP3Thdlb0wEl+aXb
	CEgL1gL0hEMaM3Z/m20vEvafAsfs7iHUYd0VipOwQcykzxtRJYfrDfI0nxrvWB//ImMm
	F923hc8gKL4NPIPdmBFy5RPQ0KxZ78qAqLMCQ=
References: <cover.1527641426.git.petrm@mellanox.com>
	<3f7f1f0580acedf385d993304d53d370a60410c2.1527641426.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <917eb572-1288-f71c-f81a-ab578016a8f3@cumulusnetworks.com>
Date: Wed, 30 May 2018 18:15:53 +0300
MIME-Version: 1.0
In-Reply-To: <3f7f1f0580acedf385d993304d53d370a60410c2.1527641426.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 2/8] net: bridge: Extract
 br_vlan_add_existing()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

On 30/05/18 03:56, Petr Machata wrote:
> Extract the code that deals with adding a preexisting VLAN to bridge CPU
> port to a separate function. A follow-up patch introduces a need to roll
> back operations in this block due to an error, and this split will make
> the error-handling code clearer.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 55 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


