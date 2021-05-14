Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erYHtcNZBE7I1lDDEg5p4qb0b9DVuP6c1KHWYqgua5A=;
 b=ugms00XOFLkMI81IBmIU6v/fgKWiq/7/DjpFFtzP0+dh1BWs0DTy1GcTobItpt1wMLyg+E36aaBnEfHHcIVOaNmWnNfv6f1YOa6pP00ohnlPCa6hVY78KzZXok0TizgzdURwjKaQUGlYM2dfNVRVZjp9H0tABBdSxu0V4vV9wk/QPs8Ge+FanKUSNDRG5pnNHRpDbw4FqHAxOHZu5PscLTT+7PqPsAolbB5QOdCIHCf7Oj7FaAoC7hlMmsZdhrEt12qHy9SP8MsQR0ZVr2mjRlgBgZkPYzXH88r6CQdXKMvtUsETt5G+iFN7gPn1peh6qzU7MIf8E2NZL7vD7rjSYw==
References: <202105140925.xZEBEK7v-lkp@intel.com>
 <CA+G9fYuSVLOOu0aEs1bm5myxDMGe1VK_MVm61BmY3dwDx_yRmA@mail.gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <7dde3521-3df5-8b65-b6a9-c974b84ab0eb@nvidia.com>
Date: Fri, 14 May 2021 13:12:12 +0300
In-Reply-To: <CA+G9fYuSVLOOu0aEs1bm5myxDMGe1VK_MVm61BmY3dwDx_yRmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [net-next:master 40/65] net/bridge/br_input.c:135:8:
 error: too many arguments to function 'br_multicast_is_router'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, kernel test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-mips@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 14/05/2021 13:06, Naresh Kamboju wrote:
> [Please ignore this email if you already know these build failures]
> 
> + Adding maintainers
> 
> On Fri, 14 May 2021 at 06:35, kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
>> head:   ea89c862f01e02ec459932c7c3113fa37aedd09a
>> commit: 1a3065a26807b4cdd65d3b696ddb18385610f7da [40/65] net: bridge: mcast: prepare is-router function for mcast router split
>> config: um-randconfig-s032-20210514 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-341-g8af24329-dirty
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=1a3065a26807b4cdd65d3b696ddb18385610f7da
>>         git remote add net-next https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>>         git fetch --no-tags net-next master
>>         git checkout 1a3065a26807b4cdd65d3b696ddb18385610f7da
>>         # save the attached .config to linux build tree
>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=um
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    net/bridge/br_input.c: In function 'br_handle_frame_finish':
>>>> net/bridge/br_input.c:135:8: error: too many arguments to function 'br_multicast_is_router'
>>      135 |        br_multicast_is_router(br, skb)) {
>>          |        ^~~~~~~~~~~~~~~~~~~~~~
>>    In file included from net/bridge/br_input.c:23:
>>    net/bridge/br_private.h:1059:20: note: declared here
>>     1059 | static inline bool br_multicast_is_router(struct net_bridge *br)
>>          |                    ^~~~~~~~~~~~~~~~~~~~~~
>>

I have already sent a patch for this one:
https://patchwork.kernel.org/project/netdevbpf/patch/20210514073233.2564187-1-razor@blackwall.org/


