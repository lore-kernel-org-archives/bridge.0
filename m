From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] IPv6 + ip6tables packet bridging?
Date: Tue, 10 Aug 2004 20:43:08 +0200
References: <20040810174239.97547.qmail@web13906.mail.yahoo.com>
In-Reply-To: <20040810174239.97547.qmail@web13906.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408102043.08578.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Scott MacKay <scottmackay@yahoo.com>, bridge@lists.osdl.org

On Tuesday 10 August 2004 19:42, Scott MacKay wrote:
> Hiyas,
>    Is there a patch for the 2.4.x series to do
> ip6tables bridging of IPv6 packets?  I was unable to
> go to 2.6 due to issues with large packets so still
> living in 2.4 land.  If there are no patches, any
> ideas on what gets patched in IPv4 to allow this
> bridging?

In 2.6 ip6tables doesn't see bridged IPv6 packets either. It should be easy to 
add, though.

cheers,
Bart

