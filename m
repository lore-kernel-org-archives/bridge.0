Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20120814101852.GA1661@minipsycho.brq.redhat.com>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-2-git-send-email-jiri@resnulli.us>
	<502A1429.9060005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502A1429.9060005@gmail.com>
Subject: Re: [Bridge] [patch net-next 01/16] net: introduce upper device
	lists
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 10:18:59 -0000
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, linux-driver@qlogic.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Tue, Aug 14, 2012 at 11:02:33AM CEST, xiyou.wangcong@gmail.com wrote:
>On 08/13/2012 11:27 PM, Jiri Pirko wrote:
>>This lists are supposed to serve for storing pointers to all upper devices.
>>Eventually it will replace dev->master pointer which is used for
>>bonding, bridge, team but it cannot be used for vlan, macvlan where
>>there might be multiple "masters" present.
>>
>>New upper device list resolves this limitation. Also, the information
>>stored in lists is used for preventing looping setups like
>>"bond->somethingelse->samebond"
>
>Hi, Jiri,
>
>I have some difficulty to understand this patch description, so take
>bridged bonding as an example, IIUC, both the bridge dev and bonding
>dev will be in the upper dev list of eth0 and eth1? And br0 will be
>in the upper dev list of bond0 too?

No. Only direct upper device is in the list.

>
>I think it would be nice to describe the hierarchy after your patches.

Hierarchy is the same after.

>
>Thanks!
>
