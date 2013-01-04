Return-Path: <davem@davemloft.net>
Date: Fri, 04 Jan 2013 13:33:31 -0800 (PST)
Message-Id: <20130104.133331.1729083969241157711.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1357289343-817-1-git-send-email-jiri@resnulli.us>
References: <1357289343-817-1-git-send-email-jiri@resnulli.us>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net-next V6 00/15] net: introduce upper device
 lists and remove dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, linux-driver@qlogic.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, linux390@de.ibm.com, kaber@trash.net

From: Jiri Pirko <jiri@resnulli.us>
Date: Fri,  4 Jan 2013 09:48:48 +0100

> This patchset adds a possibility to record upper device linkage.
> All upper<->lower devices are converted to use this mechanism right after.
> That leads to dev->master removal because this info becomes redundant since
> "master links" have the same value.

Series applied, thanks Jiri.
