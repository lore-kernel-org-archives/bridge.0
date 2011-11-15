Return-Path: <shemminger@vyatta.com>
Date: Tue, 15 Nov 2011 09:45:16 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20111115094516.3eb54a1a@nehalam.linuxnetplumber.net>
In-Reply-To: <4EC23EE7.2010606@intel.com>
References: <CAM1AHpSuruDx3CxzK=Med0iyxxwu7wxgRZib7yhBMiCVKXqzeA@mail.gmail.com>
	<4EC23EE7.2010606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] sky2 hw csum failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Martin Volf <martin.volf.42@gmail.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "wcang@sfc.wide.ad.jp" <wcang@sfc.wide.ad.jp>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, 15 Nov 2011 18:28:55 +0800
"Yan, Zheng" <zheng.z.yan@intel.com> wrote:

> I re-tested the checksum code, both CHECKSUM_NONE and CHECKSUM_COMPLETE
> cases are OK. Maybe the bug is related to sky2.
> 
> Regards
> Yan, Zheng

There are three types of receive checksumming:
  1. Hardware does not do checksumming (CHECKSUM_NONE)
  2. Hardware validates checksum (CHECKSUM_UNNECESSARY)
  3. Hardware computes sum of bytes in skb (CHECKSUM_COMPLETE)

Most hardware does #2, but sky2 uses #3.
For the second case, the hardware does not look at headers but only
reports the one's complement value in ip_summed. It is up to the
protocol layers to adjust accordingly.  This means if data is removed
or added the checksum needs to be adjusted.



