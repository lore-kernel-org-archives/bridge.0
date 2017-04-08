Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=wxlK4Eml8e/SdHQyInuuR9an+IaIgok1SPNET+k/p1I=;
	b=QbuSqRm9Nw35T6nYD40q3fv6jYx052WT5rhrnXweVEjp96hNx+KT95xPsCcTbZXSOR
	aa4zpuf/eS/YXOMKszDrd0jrYMQR1TCvCGDKoDXi64r4k4PJbH/gK4PlvfPaOnBZDzgM
	IhFcIzptiU0Ujs9ftTkjdyFw0TASnraZpmWEc=
References: <20170408114159.12722-1-idosch@mellanox.com>
	<20170408114159.12722-2-idosch@mellanox.com>
	<20170408093042.20b08c5d@plumbers-lap.home.lan>
	<20170408134938.GA28955@splinter>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <59220a2b-aa54-844d-cda5-63a42b88f188@cumulusnetworks.com>
Date: Sat, 8 Apr 2017 17:05:48 +0300
MIME-Version: 1.0
In-Reply-To: <20170408134938.GA28955@splinter>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2 1/2] bridge: implement missing
	ndo_uninit()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: cera@cera.cz, mlxsw@mellanox.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On 08/04/17 16:49, Ido Schimmel wrote:
> On Sat, Apr 08, 2017 at 09:30:42AM -0400, Stephen Hemminger wrote:
>> On Sat, 8 Apr 2017 14:41:58 +0300
>> <idosch@mellanox.com> wrote:
>>
>>>  static void br_dev_free(struct net_device *dev)
>>>  {
>>> -	struct net_bridge *br = netdev_priv(dev);
>>> -
>>> -	free_percpu(br->stats);
>>>  	free_netdev(dev);
>>>  }
>>>  
>>
>> Since the only thing left is free_netdev, you can now just set dev->destructor
>> to be free_netdev.
> 
> Fine.
> 
> Beside stylistic issues, I would appreciate comments on how this should
> be handled. Are we reverting the patch in the Fixes line or applying
> this patchset?
> 
> I prefer the first option. Then after net is merged into net-next I can
> re-post this patchset with the requested changes.
> 

+1


