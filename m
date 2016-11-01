Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=9E2WdevMzfOH5qA1b85o4C6c3rBiThXce2KJJHUGnXo=;
	b=fy/MJurtVGN0xLBpNWfAxPsi5xKDUs1zbLdlRkCmjOHZv+excEfwBp9rKbuIWBGWKT
	pQMMukPy5gCMR2NHKsLZXsqxv+9B4phHEZzevYOFG8q7kjJSN/5DgPmOJolXTlSd8rY2
	oYWS1xoGp7IQtabfD2YekZgnj4LgcHC4VN6otG/8M3lxvqMF9u8Lv30Kz/vRp+yY6Tbh
	c92TC7JB71yCl7H111LSQtcWBURRlQu8DwyCOGSoVY6LwFuPaqinXJspCcp6vPGh6uRi
	i60SyZOR54SIgAcOHt4Zm09rJUf+TxlmBzKqhaVQsnnJygr8Z/k519xVMvO8V44Cuk+4
	fmeg==
MIME-Version: 1.0
In-Reply-To: <d60077689fd40b84fade5c23ee2d3b2c0b2cfe98.1477850310.git.baruch@tkos.co.il>
References: <d60077689fd40b84fade5c23ee2d3b2c0b2cfe98.1477850310.git.baruch@tkos.co.il>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 1 Nov 2016 11:42:29 -0600
Message-ID: <CAOaVG14nMiAXkXWG4byqP=o5Z_ToZVsxHrwHHKsBTdA0ZdoLJA@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a114ab7b037e045054040d91c
Subject: Re: [Bridge] [PATCH v2] libbridge: fix headers conflict with musl
	libc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Baruch Siach <baruch@tkos.co.il>
Cc: bridge <bridge@lists.linux-foundation.org>

--001a114ab7b037e045054040d91c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I understand that musl requires some changes, but copying data is not the
correct way to handle this. Lots of work went into making Glibc and kernel
headers compatiable. It looks like MUSL needs to follow the same agreement.

On Sun, Oct 30, 2016 at 11:58 AM, Baruch Siach <baruch@tkos.co.il> wrote:

> Don't including kernel headers directly to avoid headers conflict like:
>
> In file included from .../sysroot/usr/include/linux/if_bridge.h:18:0,
>                  from libbridge.h:26,
>                  from libbridge_if.c:26:
> .../sysroot/usr/include/linux/in6.h:32:8: error: redefinition of =E2=80=
=98struct
> in6_addr=E2=80=99
>  struct in6_addr {
>         ^
> In file included from libbridge.h:24:0,
>                  from libbridge_if.c:26:
> .../sysroot/usr/include/netinet/in.h:23:8: note: originally defined here
>  struct in6_addr {
>         ^
>
> Instead copy the required linux/if_bridge.h definitions into
> libbridge_private.h.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Add #ifdef to protect against redefinition of if_bridge.h identifiers
> ---
>  libbridge/libbridge.h         |  1 -
>  libbridge/libbridge_private.h | 83 ++++++++++++++++++++++++++++++
> ++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h
> index ff047f933cd6..18b40cd90413 100644
> --- a/libbridge/libbridge.h
> +++ b/libbridge/libbridge.h
> @@ -23,7 +23,6 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <linux/if.h>
> -#include <linux/if_bridge.h>
>
>  /* defined in net/if.h but that conflicts with linux/if.h... */
>  extern unsigned int if_nametoindex (const char *__ifname);
> diff --git a/libbridge/libbridge_private.h b/libbridge/libbridge_private.=
h
> index 99a511dae00a..565025b7bccb 100644
> --- a/libbridge/libbridge_private.h
> +++ b/libbridge/libbridge_private.h
> @@ -24,7 +24,88 @@
>  #include <linux/sockios.h>
>  #include <sys/time.h>
>  #include <sys/ioctl.h>
> -#include <linux/if_bridge.h>
> +
> +/* From linux/if_ether.h */
> +#ifndef ETH_ALEN
> +#define ETH_ALEN       6
> +#endif
> +
> +/* From linux/if_bridge.h */
> +#ifndef BRCTL_GET_VERSION
> +#define BRCTL_GET_VERSION 0
> +#define BRCTL_GET_BRIDGES 1
> +#define BRCTL_ADD_BRIDGE 2
> +#define BRCTL_DEL_BRIDGE 3
> +#define BRCTL_ADD_IF 4
> +#define BRCTL_DEL_IF 5
> +#define BRCTL_GET_BRIDGE_INFO 6
> +#define BRCTL_GET_PORT_LIST 7
> +#define BRCTL_SET_BRIDGE_FORWARD_DELAY 8
> +#define BRCTL_SET_BRIDGE_HELLO_TIME 9
> +#define BRCTL_SET_BRIDGE_MAX_AGE 10
> +#define BRCTL_SET_AGEING_TIME 11
> +#define BRCTL_SET_GC_INTERVAL 12
> +#define BRCTL_GET_PORT_INFO 13
> +#define BRCTL_SET_BRIDGE_STP_STATE 14
> +#define BRCTL_SET_BRIDGE_PRIORITY 15
> +#define BRCTL_SET_PORT_PRIORITY 16
> +#define BRCTL_SET_PATH_COST 17
> +#define BRCTL_GET_FDB_ENTRIES 18
> +
> +#define BR_STATE_DISABLED 0
> +#define BR_STATE_LISTENING 1
> +#define BR_STATE_LEARNING 2
> +#define BR_STATE_FORWARDING 3
> +#define BR_STATE_BLOCKING 4
> +
> +struct __bridge_info {
> +       __u64 designated_root;
> +       __u64 bridge_id;
> +       __u32 root_path_cost;
> +       __u32 max_age;
> +       __u32 hello_time;
> +       __u32 forward_delay;
> +       __u32 bridge_max_age;
> +       __u32 bridge_hello_time;
> +       __u32 bridge_forward_delay;
> +       __u8 topology_change;
> +       __u8 topology_change_detected;
> +       __u8 root_port;
> +       __u8 stp_enabled;
> +       __u32 ageing_time;
> +       __u32 gc_interval;
> +       __u32 hello_timer_value;
> +       __u32 tcn_timer_value;
> +       __u32 topology_change_timer_value;
> +       __u32 gc_timer_value;
> +};
> +
> +struct __port_info {
> +       __u64 designated_root;
> +       __u64 designated_bridge;
> +       __u16 port_id;
> +       __u16 designated_port;
> +       __u32 path_cost;
> +       __u32 designated_cost;
> +       __u8 state;
> +       __u8 top_change_ack;
> +       __u8 config_pending;
> +       __u8 unused0;
> +       __u32 message_age_timer_value;
> +       __u32 forward_delay_timer_value;
> +       __u32 hold_timer_value;
> +};
> +
> +struct __fdb_entry {
> +       __u8 mac_addr[ETH_ALEN];
> +       __u8 port_no;
> +       __u8 is_local;
> +       __u32 ageing_timer_value;
> +       __u8 port_hi;
> +       __u8 pad0;
> +       __u16 unused;
> +};
> +#endif /* BRCTL_GET_VERSION */
>
>  #define MAX_BRIDGES    1024
>  #define MAX_PORTS      1024
> --
> 2.10.1
>
>

--001a114ab7b037e045054040d91c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I understand that musl requires some changes, but copying =
data is not the correct way to handle this. Lots of work went into making G=
libc and kernel headers compatiable. It looks like MUSL needs to follow the=
 same agreement.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Sun, Oct 30, 2016 at 11:58 AM, Baruch Siach <span dir=3D"ltr">&lt;<=
a href=3D"mailto:baruch@tkos.co.il" target=3D"_blank">baruch@tkos.co.il</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Don&#=
39;t including kernel headers directly to avoid headers conflict like:<br>
<br>
In file included from .../sysroot/usr/include/linux/<wbr>if_bridge.h:18:0,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from libbridg=
e.h:26,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from libbridg=
e_if.c:26:<br>
.../sysroot/usr/include/linux/<wbr>in6.h:32:8: error: redefinition of =E2=
=80=98struct in6_addr=E2=80=99<br>
=C2=A0struct in6_addr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
In file included from libbridge.h:24:0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from libbridg=
e_if.c:26:<br>
.../sysroot/usr/include/<wbr>netinet/in.h:23:8: note: originally defined he=
re<br>
=C2=A0struct in6_addr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
<br>
Instead copy the required linux/if_bridge.h definitions into<br>
libbridge_private.h.<br>
<br>
Signed-off-by: Baruch Siach &lt;<a href=3D"mailto:baruch@tkos.co.il">baruch=
@tkos.co.il</a>&gt;<br>
---<br>
</span>v2: Add #ifdef to protect against redefinition of if_bridge.h identi=
fiers<br>
---<br>
=C2=A0libbridge/libbridge.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br=
>
=C2=A0libbridge/libbridge_private.h | 83 ++++++++++++++++++++++++++++++<wbr=
>++++++++++++-<br>
=C2=A02 files changed, 82 insertions(+), 2 deletions(-)<br>
<span class=3D""><br>
diff --git a/libbridge/libbridge.h b/libbridge/libbridge.h<br>
index ff047f933cd6..18b40cd90413 100644<br>
--- a/libbridge/libbridge.h<br>
+++ b/libbridge/libbridge.h<br>
@@ -23,7 +23,6 @@<br>
=C2=A0#include &lt;sys/socket.h&gt;<br>
=C2=A0#include &lt;netinet/in.h&gt;<br>
=C2=A0#include &lt;linux/if.h&gt;<br>
-#include &lt;linux/if_bridge.h&gt;<br>
<br>
=C2=A0/* defined in net/if.h but that conflicts with linux/if.h... */<br>
=C2=A0extern unsigned int if_nametoindex (const char *__ifname);<br>
diff --git a/libbridge/libbridge_private.<wbr>h b/libbridge/libbridge_priva=
te.<wbr>h<br>
</span>index 99a511dae00a..565025b7bccb 100644<br>
--- a/libbridge/libbridge_private.<wbr>h<br>
+++ b/libbridge/libbridge_private.<wbr>h<br>
@@ -24,7 +24,88 @@<br>
<span class=3D"">=C2=A0#include &lt;linux/sockios.h&gt;<br>
=C2=A0#include &lt;sys/time.h&gt;<br>
=C2=A0#include &lt;sys/ioctl.h&gt;<br>
-#include &lt;linux/if_bridge.h&gt;<br>
+<br>
+/* From linux/if_ether.h */<br>
+#ifndef ETH_ALEN<br>
+#define ETH_ALEN=C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
+#endif<br>
+<br>
+/* From linux/if_bridge.h */<br>
</span>+#ifndef BRCTL_GET_VERSION<br>
<div><div class=3D"h5">+#define BRCTL_GET_VERSION 0<br>
+#define BRCTL_GET_BRIDGES 1<br>
+#define BRCTL_ADD_BRIDGE 2<br>
+#define BRCTL_DEL_BRIDGE 3<br>
+#define BRCTL_ADD_IF 4<br>
+#define BRCTL_DEL_IF 5<br>
+#define BRCTL_GET_BRIDGE_INFO 6<br>
+#define BRCTL_GET_PORT_LIST 7<br>
+#define BRCTL_SET_BRIDGE_FORWARD_DELAY 8<br>
+#define BRCTL_SET_BRIDGE_HELLO_TIME 9<br>
+#define BRCTL_SET_BRIDGE_MAX_AGE 10<br>
+#define BRCTL_SET_AGEING_TIME 11<br>
+#define BRCTL_SET_GC_INTERVAL 12<br>
+#define BRCTL_GET_PORT_INFO 13<br>
+#define BRCTL_SET_BRIDGE_STP_STATE 14<br>
+#define BRCTL_SET_BRIDGE_PRIORITY 15<br>
+#define BRCTL_SET_PORT_PRIORITY 16<br>
+#define BRCTL_SET_PATH_COST 17<br>
+#define BRCTL_GET_FDB_ENTRIES 18<br>
+<br>
+#define BR_STATE_DISABLED 0<br>
+#define BR_STATE_LISTENING 1<br>
+#define BR_STATE_LEARNING 2<br>
+#define BR_STATE_FORWARDING 3<br>
+#define BR_STATE_BLOCKING 4<br>
+<br>
+struct __bridge_info {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 designated_root;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 bridge_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 root_path_cost;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 max_age;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 hello_time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 forward_delay;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 bridge_max_age;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 bridge_hello_time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 bridge_forward_delay;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 topology_change;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 topology_change_detected;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 root_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 stp_enabled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 ageing_time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gc_interval;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 hello_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 tcn_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 topology_change_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gc_timer_value;<br>
+};<br>
+<br>
+struct __port_info {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 designated_root;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 designated_bridge;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 port_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 designated_port;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 path_cost;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 designated_cost;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 state;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 top_change_ack;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 config_pending;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 unused0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 message_age_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 forward_delay_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 hold_timer_value;<br>
+};<br>
+<br>
+struct __fdb_entry {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 mac_addr[ETH_ALEN];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 port_no;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 is_local;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 ageing_timer_value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 port_hi;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 pad0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 unused;<br>
+};<br>
</div></div>+#endif /* BRCTL_GET_VERSION */<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
=C2=A0#define MAX_BRIDGES=C2=A0 =C2=A0 1024<br>
=C2=A0#define MAX_PORTS=C2=A0 =C2=A0 =C2=A0 1024<br>
--<br>
2.10.1<br>
<br>
</div></div></blockquote></div><br></div>

--001a114ab7b037e045054040d91c--
