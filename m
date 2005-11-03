Date: Thu, 3 Nov 2005 15:05:55 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge question
Message-ID: <20051103150555.21ad7228@dxpl.pdx.osdl.net>
In-Reply-To: <30be90270511031416u205882b4tcdc769f1ec203a77@mail.gmail.com>
References: <30be90270511031416u205882b4tcdc769f1ec203a77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <u2.ireland@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 3 Nov 2005 17:16:45 -0500
Hai Wang <u2.ireland@gmail.com> wrote:

> Hello,
> 
>  Do you know why it is impossible to add more than #254 interfaces on a
> bridge, why we need such a limit, how it can be exceeded?
> 
>   Thanks!
> 
>  Regards!

You can have up 1023 interfaces with 2.6.  I didn't want to change the 2.4
code, only critical bug fixes get backported.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
