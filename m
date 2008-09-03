Message-ID: <48BDD3A8.6070500@hp.com>
Date: Tue, 02 Sep 2008 17:00:40 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
References: <48BB295A.6050200@vyatta.com>	<20080901093827.24eec86f@lxorguk.ukuu.org.uk>	<48BD6C8E.5060704@hp.com>
	<20080902.164130.156055373.davem@davemloft.net>
In-Reply-To: <20080902.164130.156055373.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] bridge: STP timer management range checking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: hancockr@shaw.ca, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen.hemminger@vyatta.com, romieu@fr.zoreil.com, shemminger@vyatta.com, dusanc@gmail.com, alan@lxorguk.ukuu.org.uk

David Miller wrote:
> From: Rick Jones <rick.jones2@hp.com>
> Date: Tue, 02 Sep 2008 09:40:46 -0700
>>Can one change the TCP maximum RTO to be smaller than specified in the specs? 
> We always min-clamp the RTO at RTO calculation time in order to be
> compatible with BSD's coarse grained times.

But tuning TCP_RTO_MAX isn't permitted right?  I'm drawing (perhaps 
flawed) parallels/distinctions between what is/isn't permitted to tweak 
for timers for one protocol versus another and wondering which may be a 
case of sauce for the goose/gander.

rick jones
