Message-ID: <457A3313.1070307@osdl.org>
Date: Fri, 08 Dec 2006 19:52:51 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
References: <176e7db30612081813s6f6440an10da265d1c5c1a98@mail.gmail.com>
In-Reply-To: <176e7db30612081813s6f6440an10da265d1c5c1a98@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Problems
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Daniel Fernandez <dafernz@gmail.com>
Cc: bridge@lists.osdl.org

Daniel Fernandez wrote:
> Hi.
>
> I am use a linux bridge with two via-rhine ethernet cards. I have
> aprox. the 3% of packet loss in the bridge. This is normal? Is it a
> possible problem of the via-rhine cards? Is best change the NICs for
> 3COM?
>
>   

What kernel version?  I added NAPI support to via-rhine in last 6 months 
(2.6.16?)

Did you enable VIA_RHINE_NAPI in your kernel config?
