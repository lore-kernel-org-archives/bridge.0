Date: Tue, 24 Aug 2004 13:59:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] SUSE 8.1 build failure
Message-Id: <20040824135922.4e9eefb2@dell_ss3.pdx.osdl.net>
In-Reply-To: <023e01c482d1$d7915c20$ba00a8c0@hasslemonkey.net>
References: <023e01c482d1$d7915c20$ba00a8c0@hasslemonkey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gareth Wheelton <gareth@hasslemonkey.net>
Cc: bridge@lists.osdl.org

The inline functions in libbridge_private.h expect HZ defined in /usr/include/asm/param.h
What does that look like on your system?
