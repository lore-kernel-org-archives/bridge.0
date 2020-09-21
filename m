Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=wPdlIs18KI5U0+lJGti5z8sy4m97lLcsvfJKYU71Zb4=;
 b=TJTi4cNhDBklHXlnU2BhmlFoP17GtWhHnpSTpszs6yBgkG0PNYcRp92G+rh3wR2wMB
 6wTDZy/tUFdfXBpBkaVMoX0+xPQifCnlheP0zbjLbul6t11emSIvi2IFXuJgJUAuhYif
 DAxKt1XmBh3zpBwP9Vf2PvxP8aeQJf1ut36EMeKkKcbRhmJdPrB9adJMPTFw0rloMKKB
 YfWBswgn5hTnD9AM3KzR01u1zNONJ7HjbNyCcZ53ZfymCCnNWz0wzMirDCFBBS6O0t/5
 q7YZA729DmydWYGDV4LZW24yTJdhFuMiH6b/9odBjqo7KtQvE/iDl2bNP+zunNrqsTpk
 8GWg==
Message-ID: <79bea5b909046ae1259481d172c2eb2a6c62aabb.camel@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Reply-To: razor@blackwall.org
Date: Mon, 21 Sep 2020 16:33:56 +0300
In-Reply-To: <202009212146.1IVUIG6Z%lkp@intel.com>
References: <20200921105526.1056983-7-razor@blackwall.org>
 <202009212146.1IVUIG6Z%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 06/16] net: bridge: mcast: rename
 br_ip's u member to dst
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, kbuild-all@lists.01.org, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, bridge@lists.linux-foundation.org, roopa@nvidia.com, davem@davemloft.net, Sven Eckelmann <sven@narfation.org>

On Mon, 2020-09-21 at 21:30 +0800, kernel test robot wrote:
> Hi Nikolay,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Nikolay-Aleksandrov/net-bridge-mcast-IGMPv3-MLDv2-fast-path-part-2/20200921-185933
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 3cec0369905d086a56a7515f3449982403057599
> config: riscv-allyesconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    net/batman-adv/multicast.c: In function 'batadv_mcast_mla_br_addr_cpy':
> > > net/batman-adv/multicast.c:564:20: error: 'const struct br_ip' has no member named 'u'
>      564 |   ip_eth_mc_map(src->u.ip4, dst);
>          |                    ^~
>    net/batman-adv/multicast.c:567:23: error: 'const struct br_ip' has no member named 'u'
>      567 |   ipv6_eth_mc_map(&src->u.ip6, dst);
>          |                       ^~
> 

Hrm, I'm pretty sure I tested batman, but apparently I missed
CONFIG_BATMAN_ADV_MCAST. I'll fix it up and send v2 after some
time to give people the chance to comment on the rest of the set.

Thanks!


