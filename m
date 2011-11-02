Return-Path: <vvs@parallels.com>
Message-ID: <4EB1A229.9030602@parallels.com>
From: Vasily Averin <vvs@parallels.com>
MIME-Version: 1.0
References: <4EB19549.4010601@parallels.com>
	<20111102123106.107f4cb8@nehalam.linuxnetplumber.net>
In-Reply-To: <20111102123106.107f4cb8@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Reset IPCB on forward non-local
	packets in br_handle_frame_finish()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 02 Nov 2011 20:03:26 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, devel@openvz.org, Herbert Xu <herbert@gondor.hengli.com.au>

On 11/02/2011 11:31 PM, Stephen Hemminger wrote:
> On Wed, 02 Nov 2011 23:08:57 +0400
> Vasily Averin <vvs@parallels.com> wrote:
> 
>> if dst is not local br_handle_frame_finish() does not clone original skb and
>> forgets to reset IPCB before return to IP stack. it can lead to stack corruption
>> in icmp_send()

> What kernel version are you using? There were several previous fixes
> in br_netfilter to deal with this type of issue over the last year.

Originally it was noticed on RHEL6-based kernel

You are right, in mainline this issue was fixed in br_nf_forward_ip() long time ago.

thank you,
	Vasily Averin
