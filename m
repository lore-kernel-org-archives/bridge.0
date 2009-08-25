MIME-Version: 1.0
In-Reply-To: <cfeab66d0908200828l52c46f25la0598732e0c684d4@mail.gmail.com>
References: <cfeab66d0908190514s3f283e5dh7487dca701203f1e@mail.gmail.com>
	<cfeab66d0908200828l52c46f25la0598732e0c684d4@mail.gmail.com>
Date: Tue, 25 Aug 2009 17:08:38 +0530
Message-ID: <cfeab66d0908250438r4fe768b6k1cef02d1c0015d6c@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

i can see problem in   2.6.22.18 ,but not in 2.6.26.8 ..... Is there
any patch available ??//






On Thu, Aug 20, 2009 at 8:58 PM, ratheesh k<ratheesh.ksz@gmail.com> wrote:
> in linux kernel =A0, in =A0net/sched/cls_fw.c =A0file =A0, fw_classify is
> called every time =A0tc filter =A0is hit .
> skb->mark is =A0zero when u use rules like
>
> =A0> iptables =A0-t mangle -A PREROTUING -p icmp -i br0 -j MARK --set-mar=
k 2
>> iptables =A0-t mangle -A PREROTUING -p icmp =A0-s 192.168.1.0/24 =A0-d !
>> 192.168.1.0/24 -j MARK --set-mark 2
>> iptables =A0-t mangle -A FORWARD =A0-p icmp =A0-i br0 -o eth1 -j MARK --=
set-mark 2
>
> But if u use
>>iptables =A0-t mangle -A PREROTUING -p icmp -j MARK --set-mark 2
>
> the skb->mark is 2 =A0, correct value .
>
> This problem happens only with bridge . when i tried with one of the
> interface it works perfectly .
>
> Thanks,
> Ratheesh
>
>
>
>
> On Wed, Aug 19, 2009 at 5:44 PM, ratheesh k<ratheesh.ksz@gmail.com> wrote=
:
>> =A0I have two interfaces , eth0 and ap0 bridged together to form br0 .
>> And another interfaces eth1 on wan side .
>>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 br0 <------------------------> eth1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( eth0 , ap0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { =A0lan =A0} =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 {wan}
>>
>> packets from lan side are nated =A0to eth1 . =A0i have qos rules on both
>> br0 and eth1 . =A0when i googled i found that "mangling packets on br0
>> and using fw filters wont work on linux bridge ".. Is this true ?? Can
>> you tell me why ??
>>
>> But the funny thing is i colored packets =A0in prerouting chain =A0only
>> specifying protocol ( not specifying interface )
>>
>> =A0iptables =A0-t mangle -A PREROTUING -p icmp -j MARK --set-mark 2 =A0 =
and
>> i have filter rule to put =A0packets tat are fw marked as 2 to put into
>> some flow . This works fine , when i send an icmp packet from lan to
>> wan side !!!!!!! ??????????
>>
>> But if =A0try any of below rules =A0intsead of above , =A0it wont work
>>
>> iptables =A0-t mangle -A PREROTUING -p icmp -i br0 -j MARK --set-mark 2
>> iptables =A0-t mangle -A PREROTUING -p icmp =A0-s 192.168.1.0/24 =A0-d !
>> 192.168.1.0/24 -j MARK --set-mark 2
>> iptables =A0-t mangle -A FORWARD =A0-p icmp =A0-i br0 -o eth1 -j MARK --=
set-mark 2
>>
>> i dont know y ????????
>>
>> =A0I should go for ebtables to mark packets ???????? then it will work ?=
??
>>
>
