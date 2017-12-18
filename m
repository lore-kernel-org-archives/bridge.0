Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
	<CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
	<CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
	<20171216093520.74b7fafd@xeon-e3>
	<CA+k9h3PEQ+MBq4A2a=k-Dgs=e5vGatc6oKQZd3V7iRysipHjMg@mail.gmail.com>
	<CA+k9h3N5+DMFj3jB8s8LinxpzicDwy_jbe42+M7e4ohgt02YxQ@mail.gmail.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <5283ecbb-4292-9420-7f0e-0d8922b8ad35@lab.ntt.co.jp>
Date: Mon, 18 Dec 2017 11:54:20 +0900
MIME-Version: 1.0
In-Reply-To: <CA+k9h3N5+DMFj3jB8s8LinxpzicDwy_jbe42+M7e4ohgt02YxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adrian P <adrian27oradea@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On 2017/12/17 5:01, Adrian P wrote:
...
> Further investigation reveals something strange: when the
> communication starts with an arp request (which happens almost all the
> time), the bridge wrongly assigns the eth0 mac address to port 1,
> instead of port 3.
> 
> Flow again:
> 
> default gw --- vmware --- [ ens160 bridge tap ] --- eth0
> 
> On my bridge, ens160 is port 1, and the tap interface is port 3. Eth0
> mac address is fa:16:3e:9a:04:95
> 
> What I have found is that in the forwarding table, the bridge wrongly
> assigns the eth0 mac address to the port 1, which is ens160 interface,
> instead of assigning it to the port 3, which is the tap interface.
> This happens only if the arp table in the cirros VM instance does not
> contain the mac address of the destination I am pinging (default gw in
> this case), so the cirros VM sends an arp request. See below the eth0
> mac address wrongly  assigned in the forwarding table to the port 1:
> 
> # brctl showmacs brq025a9a94-58 | grep fa:16:3e:9a:04:95
>   1     fa:16:3e:9a:04:95       no                 0.67
> 
> However, if I manually add the mac address of the destination IP I am
> pining into the cirros VM instance arp table, and there is no arp
> request sent, just icmp packets going out, then the bridge correctly
> assigns the eth0 mac address to the port 3, which is the tap
> interface, and everything starts working fine. See below the eth0 mac
> address correctly assigned in the forwarding table to the port 3:
> 
> # brctl showmacs brq025a9a94-58 | grep fa:16:3e:9a:04:95
>   3     fa:16:3e:9a:04:95       no                 9.26
> 

It looks like the broadcast arp request is coming back from gw or
vmware. Would you check it?

-- 
Toshiaki Makita

