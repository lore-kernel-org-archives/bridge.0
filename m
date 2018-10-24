Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <CABkmPjTsn31GSE7MPFzsKcQLGTYJk2KmDr_0uvK_q4+wvwtdxQ@mail.gmail.com>
	<CABkmPjRidqu1YT783GS7nvd=sCuYxg54YYOzEjmk43ZF7Bag=g@mail.gmail.com>
	<94713271-056d-7bdf-eab1-ce4b22a7d1d3@lab.ntt.co.jp>
	<CABkmPjQNcjvekx1j7cnkhG0NAoko0uK-RerytyKFgLafArh_Sw@mail.gmail.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <8b235ba6-6a88-a6ec-8b35-ca82859a9380@lab.ntt.co.jp>
Date: Wed, 24 Oct 2018 14:12:47 +0900
MIME-Version: 1.0
In-Reply-To: <CABkmPjQNcjvekx1j7cnkhG0NAoko0uK-RerytyKFgLafArh_Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] !vlan_enabled but programs pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Soohoon Lee <soohoon@gmail.com>
Cc: bridge@lists.linux-foundation.org

On 2018/10/24 13:45, Soohoon Lee wrote:
> I think NETIF_F_HW_VLAN_CTAG_FILTER is hardcoded in ixgbevf.
> 
> ixgbevf_probe()
>         netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
> 
> Like I said in the second email, vlan support was disabled in host/ixgbe driver.
> 
> I wonder if there's any mechanism to find whether vlan is enabled in
> the host/ixgbe from ixgbevf.

Not sure. Maybe through mbx? Probably you'll get a better answer by
asking intel folks. Or, as intel publishes their NIC's datasheet online,
you can check if vf has such a mechanism by yourself.

-- 
Toshiaki Makita

