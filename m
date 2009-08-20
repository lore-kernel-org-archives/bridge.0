MIME-Version: 1.0
In-Reply-To: <cfeab66d0908190514s3f283e5dh7487dca701203f1e@mail.gmail.com>
References: <cfeab66d0908190514s3f283e5dh7487dca701203f1e@mail.gmail.com>
Date: Thu, 20 Aug 2009 20:58:29 +0530
Message-ID: <cfeab66d0908200828l52c46f25la0598732e0c684d4@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] packet mangling and qos on bridge .
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

in linux kernel  , in  net/sched/cls_fw.c  file  , fw_classify is
called every time  tc filter  is hit .
skb->mark is  zero when u use rules like

 > iptables  -t mangle -A PREROTUING -p icmp -i br0 -j MARK --set-mark 2
> iptables  -t mangle -A PREROTUING -p icmp  -s 192.168.1.0/24  -d !
> 192.168.1.0/24 -j MARK --set-mark 2
> iptables  -t mangle -A FORWARD  -p icmp  -i br0 -o eth1 -j MARK --set-mark 2

But if u use
>iptables  -t mangle -A PREROTUING -p icmp -j MARK --set-mark 2

the skb->mark is 2  , correct value .

This problem happens only with bridge . when i tried with one of the
interface it works perfectly .

Thanks,
Ratheesh




On Wed, Aug 19, 2009 at 5:44 PM, ratheesh k<ratheesh.ksz@gmail.com> wrote:
>  I have two interfaces , eth0 and ap0 bridged together to form br0 .
> And another interfaces eth1 on wan side .
>
>
>                   br0 <------------------------> eth1
>               ( eth0 , ap0)
>                 {  lan  }                         {wan}
>
> packets from lan side are nated  to eth1 .  i have qos rules on both
> br0 and eth1 .  when i googled i found that "mangling packets on br0
> and using fw filters wont work on linux bridge ".. Is this true ?? Can
> you tell me why ??
>
> But the funny thing is i colored packets  in prerouting chain  only
> specifying protocol ( not specifying interface )
>
>  iptables  -t mangle -A PREROTUING -p icmp -j MARK --set-mark 2   and
> i have filter rule to put  packets tat are fw marked as 2 to put into
> some flow . This works fine , when i send an icmp packet from lan to
> wan side !!!!!!! ??????????
>
> But if  try any of below rules  intsead of above ,  it wont work
>
> iptables  -t mangle -A PREROTUING -p icmp -i br0 -j MARK --set-mark 2
> iptables  -t mangle -A PREROTUING -p icmp  -s 192.168.1.0/24  -d !
> 192.168.1.0/24 -j MARK --set-mark 2
> iptables  -t mangle -A FORWARD  -p icmp  -i br0 -o eth1 -j MARK --set-mark 2
>
> i dont know y ????????
>
>  I should go for ebtables to mark packets ???????? then it will work ???
>
