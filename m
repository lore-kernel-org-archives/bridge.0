Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1437560929-25827-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1437560929-25827-1-git-send-email-nikolay@cumulusnetworks.com>
Date: Wed, 22 Jul 2015 10:03:43 -0700
Message-ID: <CAHA+R7PTV5aTk2JyaaCQ1awi_Cwz+jzA4tv9n2nEvaFxhuD0Pg@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next] bridge: mcast: when multicast is
 disabled flush the groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>

On Wed, Jul 22, 2015 at 3:28 AM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> From: Satish Ashok <sashok@cumulusnetworks.com>
>
> Once multicast gets disabled we should flush the groups.
> Example:
> # bridge mdb add dev br0 port eth3 grp 239.0.0.1
> # bridge mdb
> dev br0 port eth3 grp 239.0.0.1 temp
> # echo 0 > multicast_snooping
> # bridge mdb

Why? Why we can't save the mdb config for a mcast snooping flip?
