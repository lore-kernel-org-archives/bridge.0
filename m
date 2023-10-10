Return-Path: <scottwadkins1@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02319404CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C757404A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696965073; x=1697569873;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyqFSwEqGkCcQPfwOFtHoe2igNX6NDHv3HLE4cXNq50=;
 b=KTn2NLxzv2b+55f63CtOfudc1Cl1gFpWfSsqcqcQJ7lWVfcrskIjUovkM5SlU1jygQ
 KWQnFIrXhX835hm1I93WQvJ+X9lNP0oKw3R8Gqr6qT8hOLub+TjBdKdjR9qQdPhi9rnI
 xJvr2GD9fhtFp7msM8S/YmsAbH4AJZMNRtNry2Fee0eB22DlqWCtQ5xOg/JvkiXRFJp0
 eDvUQDnKfC53jPbNxBI0uYwoPGob4cHTKlANLuAZeOjBIYABurpNGjI6FPgBMFYs9esh
 O2roV761Ki5ApdgLUa5i+vR5YDV3gW1rWeCWM9BnU8mSctw8zhu+xkJntm4Az+Q01FSn
 GJhA==
MIME-Version: 1.0
References: <20231009100618.2911374-1-amcohen@nvidia.com>
 <20231009100618.2911374-12-amcohen@nvidia.com>
In-Reply-To: <20231009100618.2911374-12-amcohen@nvidia.com>
From: Scott Wadkins <scottwadkins1@gmail.com>
Date: Tue, 10 Oct 2023 12:11:00 -0700
Message-ID: <CAAvfbz8cBQ__5vRqd6=3_6VcyYaHk8LT2qtKYJkFdM7gr6__aQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000061e37206076178dd"
Subject: Re: [Bridge] [PATCH net-next 11/11] selftests: fdb_flush: Add test
 cases for FDB flush with bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, davem@davemloft.net, mlxsw@nvidia.com, linux-kselftest@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org

--00000000000061e37206076178dd
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 10, 2023, 11:53 AM Amit Cohen via Bridge <
bridge@lists.linux-foundation.org> wrote:

> Extend the test to check flushing with bridge device, test flush by device
> and by VID.
>
> Add test case for flushing with "self" and "master" and attributes that are
> supported only in one driver, this is unrecommended configuration, check it
> to verify that user gets an error.
>
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>  tools/testing/selftests/net/fdb_flush.sh | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/tools/testing/selftests/net/fdb_flush.sh
> b/tools/testing/selftests/net/fdb_flush.sh
> index 3050b031f46d..90e7a29e0476 100755
> --- a/tools/testing/selftests/net/fdb_flush.sh
> +++ b/tools/testing/selftests/net/fdb_flush.sh
> @@ -32,6 +32,9 @@ TESTS="
>         $FLUSH_BY_FLAG_TESTS
>         vxlan_test_flush_by_several_args
>         vxlan_test_flush_by_remote_attributes
> +       bridge_test_flush_by_dev
> +       bridge_test_flush_by_vlan
> +       bridge_vxlan_test_flush
>  "
>
>  : ${VERBOSE:=0}
> @@ -647,6 +650,93 @@ vxlan_test_flush_by_remote_attributes()
>         log_test $? 0 "Check how many entries were flushed"
>  }
>
> +bridge_test_flush_by_dev()
> +{
> +       local dst_ip=192.0.2.1
> +       local br0_n_ent_t0=$($BRIDGE fdb show dev br0 | wc -l)
> +       local br1_n_ent_t0=$($BRIDGE fdb show dev br1 | wc -l)
> +
> +       fdb_add_mac_pool_1 br0 dst $dst_ip
> +       fdb_add_mac_pool_2 br1 dst $dst_ip
> +
> +       # Each 'fdb add' command adds one extra entry in the bridge with
> the
> +       # default vlan.
> +       local exp_br0_n_ent=$(($br0_n_ent_t0 + 2 * $mac_pool_1_len))
> +       local exp_br1_n_ent=$(($br1_n_ent_t0 + 2 * $mac_pool_2_len))
> +
> +       fdb_check_n_entries_by_dev_filter br0 $exp_br0_n_ent
> +       fdb_check_n_entries_by_dev_filter br1 $exp_br1_n_ent
> +
> +       run_cmd "$BRIDGE fdb flush dev br0"
> +       log_test $? 0 "Flush FDB by dev br0"
> +
> +       # The default entry should not be flushed
> +       fdb_check_n_entries_by_dev_filter br0 1
> +       log_test $? 0 "Flush FDB by dev br0 - test br0 entries"
> +
> +       fdb_check_n_entries_by_dev_filter br1 $exp_br1_n_ent
> +       log_test $? 0 "Flush FDB by dev br0 - test br1 entries"
> +}
> +
> +bridge_test_flush_by_vlan()
> +{
> +       local vlan_1=10
> +       local vlan_2=20
> +       local vlan_1_ent_t0
> +       local vlan_2_ent_t0
> +
> +       $BRIDGE vlan add vid $vlan_1 dev br0 self
> +       $BRIDGE vlan add vid $vlan_2 dev br0 self
> +
> +       vlan_1_ent_t0=$($BRIDGE fdb show dev br0 | grep "vlan $vlan_1" |
> wc -l)
> +       vlan_2_ent_t0=$($BRIDGE fdb show dev br0 | grep "vlan $vlan_2" |
> wc -l)
> +
> +       fdb_add_mac_pool_1 br0 vlan $vlan_1
> +       fdb_add_mac_pool_2 br0 vlan $vlan_2
> +
> +       local exp_vlan_1_ent=$(($vlan_1_ent_t0 + $mac_pool_1_len))
> +       local exp_vlan_2_ent=$(($vlan_2_ent_t0 + $mac_pool_2_len))
> +
> +       fdb_check_n_entries_by_dev_filter br0 $exp_vlan_1_ent vlan $vlan_1
> +       fdb_check_n_entries_by_dev_filter br0 $exp_vlan_2_ent vlan $vlan_2
> +
> +       run_cmd "$BRIDGE fdb flush dev br0 vlan $vlan_1"
> +       log_test $? 0 "Flush FDB by dev br0 and vlan $vlan_1"
> +
> +       fdb_check_n_entries_by_dev_filter br0 0 vlan $vlan_1
> +       log_test $? 0 "Test entries with vlan $vlan_1"
> +
> +       fdb_check_n_entries_by_dev_filter br0 $exp_vlan_2_ent vlan $vlan_2
> +       log_test $? 0 "Test entries with vlan $vlan_2"
> +}
> +
> +bridge_vxlan_test_flush()
> +{
> +       local vlan_1=10
> +       local dst_ip=192.0.2.1
> +
> +       $IP link set dev vx10 master br0
> +       $BRIDGE vlan add vid $vlan_1 dev br0 self
> +       $BRIDGE vlan add vid $vlan_1 dev vx10
> +
> +       fdb_add_mac_pool_1 vx10 vni 3000 dst $dst_ip self master
> +
> +       fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vlan $vlan_1
> +       fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len vni 3000
> +
> +       # Such command should fail in VXLAN driver as vlan is not
> supported,
> +       # but the command should flush the entries in the bridge
> +       run_cmd "$BRIDGE fdb flush dev vx10 vlan $vlan_1 master self"
> +       log_test $? 255 \
> +               "Flush FDB by dev vx10, vlan $vlan_1, master and self"
> +
> +       fdb_check_n_entries_by_dev_filter vx10 0 vlan $vlan_1
> +       log_test $? 0 "Test entries with vlan $vlan_1"
> +
> +       fdb_check_n_entries_by_dev_filter vx10 $mac_pool_1_len dst $dst_ip
> +       log_test $? 0 "Test entries with dst $dst_ip"
> +}
> +
>  setup()
>  {
>         IP="ip -netns ns1"
> @@ -656,10 +746,16 @@ setup()
>
>         $IP link add name vx10 type vxlan id 1000 dstport "$VXPORT"
>         $IP link add name vx20 type vxlan id 2000 dstport "$VXPORT"
> +
> +       $IP link add br0 type bridge vlan_filtering 1
> +       $IP link add br1 type bridge vlan_filtering 1
>  }
>
>  cleanup()
>  {
> +       $IP link del dev br1
> +       $IP link del dev br0
> +
>         $IP link del dev vx20
>         $IP link del dev vx10
>
> --
> 2.40.1
>
>

--00000000000061e37206076178dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Oct 10, 2023, 11:53 AM Amit Cohen via Bridge &lt;=
<a href=3D"mailto:bridge@lists.linux-foundation.org">bridge@lists.linux-fou=
ndation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Extend t=
he test to check flushing with bridge device, test flush by device<br>
and by VID.<br>
<br>
Add test case for flushing with &quot;self&quot; and &quot;master&quot; and=
 attributes that are<br>
supported only in one driver, this is unrecommended configuration, check it=
<br>
to verify that user gets an error.<br>
<br>
Signed-off-by: Amit Cohen &lt;<a href=3D"mailto:amcohen@nvidia.com" target=
=3D"_blank" rel=3D"noreferrer">amcohen@nvidia.com</a>&gt;<br>
---<br>
=C2=A0tools/testing/selftests/net/fdb_flush.sh | 96 +++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 96 insertions(+)<br>
<br>
diff --git a/tools/testing/selftests/net/fdb_flush.sh b/tools/testing/selft=
ests/net/fdb_flush.sh<br>
index 3050b031f46d..90e7a29e0476 100755<br>
--- a/tools/testing/selftests/net/fdb_flush.sh<br>
+++ b/tools/testing/selftests/net/fdb_flush.sh<br>
@@ -32,6 +32,9 @@ TESTS=3D&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $FLUSH_BY_FLAG_TESTS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_test_flush_by_several_args<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_test_flush_by_remote_attributes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_test_flush_by_dev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_test_flush_by_vlan<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bridge_vxlan_test_flush<br>
=C2=A0&quot;<br>
<br>
=C2=A0: ${VERBOSE:=3D0}<br>
@@ -647,6 +650,93 @@ vxlan_test_flush_by_remote_attributes()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_test $? 0 &quot;Check how many entries were=
 flushed&quot;<br>
=C2=A0}<br>
<br>
+bridge_test_flush_by_dev()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local dst_ip=3D192.0.2.1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local br0_n_ent_t0=3D$($BRIDGE fdb show dev br0=
 | wc -l)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local br1_n_ent_t0=3D$($BRIDGE fdb show dev br1=
 | wc -l)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_add_mac_pool_1 br0 dst $dst_ip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_add_mac_pool_2 br1 dst $dst_ip<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Each &#39;fdb add&#39; command adds one extra=
 entry in the bridge with the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# default vlan.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local exp_br0_n_ent=3D$(($br0_n_ent_t0 + 2 * $m=
ac_pool_1_len))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local exp_br1_n_ent=3D$(($br1_n_ent_t0 + 2 * $m=
ac_pool_2_len))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 $exp_br0_=
n_ent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br1 $exp_br1_=
n_ent<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_cmd &quot;$BRIDGE fdb flush dev br0&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Flush FDB by dev br0&quot;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# The default entry should not be flushed<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Flush FDB by dev br0 - test=
 br0 entries&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br1 $exp_br1_=
n_ent<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Flush FDB by dev br0 - test=
 br1 entries&quot;<br>
+}<br>
+<br>
+bridge_test_flush_by_vlan()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local vlan_1=3D10<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local vlan_2=3D20<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local vlan_1_ent_t0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local vlan_2_ent_t0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$BRIDGE vlan add vid $vlan_1 dev br0 self<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$BRIDGE vlan add vid $vlan_2 dev br0 self<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vlan_1_ent_t0=3D$($BRIDGE fdb show dev br0 | gr=
ep &quot;vlan $vlan_1&quot; | wc -l)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vlan_2_ent_t0=3D$($BRIDGE fdb show dev br0 | gr=
ep &quot;vlan $vlan_2&quot; | wc -l)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_add_mac_pool_1 br0 vlan $vlan_1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_add_mac_pool_2 br0 vlan $vlan_2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local exp_vlan_1_ent=3D$(($vlan_1_ent_t0 + $mac=
_pool_1_len))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local exp_vlan_2_ent=3D$(($vlan_2_ent_t0 + $mac=
_pool_2_len))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 $exp_vlan=
_1_ent vlan $vlan_1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 $exp_vlan=
_2_ent vlan $vlan_2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_cmd &quot;$BRIDGE fdb flush dev br0 vlan $v=
lan_1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Flush FDB by dev br0 and vl=
an $vlan_1&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 0 vlan $v=
lan_1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Test entries with vlan $vla=
n_1&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter br0 $exp_vlan=
_2_ent vlan $vlan_2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Test entries with vlan $vla=
n_2&quot;<br>
+}<br>
+<br>
+bridge_vxlan_test_flush()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local vlan_1=3D10<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local dst_ip=3D192.0.2.1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$IP link set dev vx10 master br0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$BRIDGE vlan add vid $vlan_1 dev br0 self<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$BRIDGE vlan add vid $vlan_1 dev vx10<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_add_mac_pool_1 vx10 vni 3000 dst $dst_ip se=
lf master<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter vx10 $mac_poo=
l_1_len vlan $vlan_1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter vx10 $mac_poo=
l_1_len vni 3000<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Such command should fail in VXLAN driver as v=
lan is not supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# but the command should flush the entries in t=
he bridge<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_cmd &quot;$BRIDGE fdb flush dev vx10 vlan $=
vlan_1 master self&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 255 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Flush FDB by =
dev vx10, vlan $vlan_1, master and self&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter vx10 0 vlan $=
vlan_1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Test entries with vlan $vla=
n_1&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdb_check_n_entries_by_dev_filter vx10 $mac_poo=
l_1_len dst $dst_ip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log_test $? 0 &quot;Test entries with dst $dst_=
ip&quot;<br>
+}<br>
+<br>
=C2=A0setup()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 IP=3D&quot;ip -netns ns1&quot;<br>
@@ -656,10 +746,16 @@ setup()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $IP link add name vx10 type vxlan id 1000 dstpo=
rt &quot;$VXPORT&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $IP link add name vx20 type vxlan id 2000 dstpo=
rt &quot;$VXPORT&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$IP link add br0 type bridge vlan_filtering 1<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$IP link add br1 type bridge vlan_filtering 1<b=
r>
=C2=A0}<br>
<br>
=C2=A0cleanup()<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$IP link del dev br1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$IP link del dev br0<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $IP link del dev vx20<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $IP link del dev vx10<br>
<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div>

--00000000000061e37206076178dd--
