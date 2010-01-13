MIME-Version: 1.0
In-Reply-To: <20100113083058.79d521c6@nehalam>
Message-ID: <001636c5b1ffc54228047d0e8583@google.com>
Date: Wed, 13 Jan 2010 16:47:14 +0000
From: jhautbois@gmail.com
Content-Type: multipart/alternative; boundary=001636c5b1ffc54218047d0e8580
Subject: [Bridge] =?iso-8859-1?q?Re=A0=3ARe=3A__Re_=3ARe=3A_Re_=3ARe=3A_Br?=
	=?iso-8859-1?q?idging_LACP_=28802=2E3ad=29_frames_not_working?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>, Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

--001636c5b1ffc54218047d0e8580
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

(snip)
> I meant they get processed locally, before that they were dropped.

> The best solution is to write an ebtables rule to forward them.

Mmh, I can understand that, but I can't see which kind of rule would do  
that.
Something like :
ebtables -A FORWARDING -p 0x8809 -j ACCEPT ??

But I think this will not do anything, because it is forwarding by default.
Or there is something I can't see :-).

JM

--001636c5b1ffc54218047d0e8580
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

(snip) <br />&gt; I meant they get processed locally, before that they were=
 dropped.<br />&gt; <br />&gt; The best solution is to write an ebtables ru=
le to forward them.<br /><br />Mmh, I can understand that, but I can&#39;t =
see which kind of rule would do that.<br />Something like :<br />ebtables -=
A FORWARDING -p 0x8809 -j ACCEPT ??<br /><br />But I think this will not do=
 anything, because it is forwarding by default.<br />Or there is something =
I can&#39;t see :-).<br /><br />JM
--001636c5b1ffc54218047d0e8580--
