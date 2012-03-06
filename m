Return-Path: <Matthew_Plummer@selinc.com>
MIME-Version: 1.0
Message-ID: <OFB4C9ADD0.BDCDCF59-ON882579B9.000B573E-882579B9.000B6AA6@selinc.com>
From: Matthew_Plummer@selinc.com
Date: Mon, 5 Mar 2012 18:04:41 -0800
Content-Type: multipart/alternative;
	boundary="=_alternative 000B6AA4882579B9_="
Subject: [Bridge] Patch for RSTP Bridge Detection State Machine
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.
--=_alternative 000B6AA4882579B9_=
Content-Type: text/plain; charset="US-ASCII"

In rstplib/edge.c the IEEE 802.1D Standard requires verifying sendRSTP and
proposing when transitioning to an edge port.

rstplib/edge.c
@@ -61,7 +61,7 @@ STP_edge_enter_state (STATE_MACH_T *s)
      break;
    case RESOLVED:
      if (! port->wasInitBpdu) {
-          port->operEdge = port->adminEdge;
+          port->operEdge = True;
      }
      break;
  }
@@ -91,7 +91,7 @@ STP_edge_check_conditions (STATE_MACH_T *s)
        return STP_hop_2_state (s, RESOLVED);
      }

-      if (! port->lnkWhile)  {
+      if ((!port->lnkWhile) && (port->proposing) && (port->sendRSTP))  {
#ifdef STP_DBG
        if (s->debug)
          stp_trace ("port %s 'edge' resolved by timer", port->port_name);
--=_alternative 000B6AA4882579B9_=
Content-Type: text/html; charset="US-ASCII"

<tt><font size=2>In rstplib/edge.c the IEEE 802.1D Standard requires verifying
sendRSTP and<br>
proposing when transitioning to an edge port.<br>
<br>
rstplib/edge.c<br>
@@ -61,7 +61,7 @@ STP_edge_enter_state (STATE_MACH_T *s)<br>
 &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp;case RESOLVED:<br>
 &nbsp; &nbsp; &nbsp;if (! port-&gt;wasInitBpdu) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;port-&gt;operEdge = port-&gt;adminEdge;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;port-&gt;operEdge = True;<br>
 &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp;}<br>
@@ -91,7 +91,7 @@ STP_edge_check_conditions (STATE_MACH_T *s)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return STP_hop_2_state (s, RESOLVED);<br>
 &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp;if (! port-&gt;lnkWhile) &nbsp;{<br>
+ &nbsp; &nbsp; &nbsp;if ((!port-&gt;lnkWhile) &amp;&amp; (port-&gt;proposing)
&amp;&amp; (port-&gt;sendRSTP)) &nbsp;{<br>
#ifdef STP_DBG<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (s-&gt;debug)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stp_trace (&quot;port %s 'edge' resolved
by timer&quot;, port-&gt;port_name);</font></tt>
--=_alternative 000B6AA4882579B9_=--
