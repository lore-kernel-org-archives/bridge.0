DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
	b=cjBcHvPN+8hxFhViRwO3EQy7kaRbjF3YHMTqT/KlxTkLjpztL3s4WKpTPtN7R310xV/UUqBLPReq6fjhiCCya+Ijr5swhsUg8JwJxC+uFptQT4pbFolIsFH4H3kokcgCbWGJEieUQvIpj72N7y+h2bby9yglOy+ImschXMqPqfk=
Message-ID: <2e59e6970707051702x7d264db4te7a34f7b6db0a5ee@mail.gmail.com>
Date: Thu, 5 Jul 2007 19:02:46 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <2e59e6970707042131t7ca6cb19jf456356a06a7c006@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_145163_68144.1183680166229"
References: <2e59e6970707042131t7ca6cb19jf456356a06a7c006@mail.gmail.com>
Subject: [Bridge] jumpstart stp port to forwarding state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_145163_68144.1183680166229
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry if this is a dupe, but the mailing list join email got delayed by 10
or 12 hours and so I think this message wasn't accepted:

----------------

I've googled for this, but since there are so many pages talking about linux
boxes connected to CIsco equipment, I can't find anything relevant.

Does linux bridging support anything like cisco's portfast (port starts in
forwarding state)?  Is there a way (sysfs, ioctl) to at least change a port
to forwarding immediately?  Even bridges with stp disabled take some time
bringing ports up after a topology change.  If the delay can't be
eliminated, can I wait for it somehow in my startup scripts to avoid initial
connection failures?

My preference would be to have something like:

brctl portfast br0 bond0.10 on

or

brctl initialstate br0 bond0.10 forwarding



Also, can stp disable all ports in the same bridge?  I would assume not, a
minimum spanning tree needs at least one port forwarding (could that port
somehow be a different interface on the same box, not a member of the
bridge?).  If at least one port is always forwarding, could the minimum cost
port be set to forwarding by default when the bridge is brought up (ip link
set br0 up) irrespective of any portfast-alike setting?

I'm trying to minimize startup time on a firewall.

Thanks for any information you can provide.

Ben Voigt

------=_Part_145163_68144.1183680166229
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote">Sorry if this is a dupe, but the mailing list join email got delayed by 10 or 12 hours and so I think this message wasn&#39;t accepted:<br><br>----------------<br><br></span>I&#39;ve googled for this, but since there are so many pages talking about linux boxes connected to CIsco equipment, I can&#39;t find anything relevant.
<br><br>Does linux bridging support anything like cisco&#39;s portfast (port starts in forwarding state)?&nbsp; Is there a way (sysfs, ioctl) to at least change a port to forwarding immediately?&nbsp; Even bridges with stp disabled take some time bringing ports up after a topology change.&nbsp; If the delay can&#39;t be eliminated, can I wait for it somehow in my startup scripts to avoid initial connection failures?
<br><br>My preference would be to have something like:<br><br>brctl portfast br0 bond0.10 on<br><br>or<br><br>brctl initialstate br0 bond0.10 forwarding<br><br><br><br>Also, can stp disable all ports in the same bridge?&nbsp; I would assume not, a minimum spanning tree needs at least one port forwarding (could that port somehow be a different interface on the same box, not a member of the bridge?).&nbsp; If at least one port is always forwarding, could the minimum cost port be set to forwarding by default when the bridge is brought up (ip link set br0 up) irrespective of any portfast-alike setting?
<br><br>I&#39;m trying to minimize startup time on a firewall.<br><br>Thanks for any information you can provide.<br><br>Ben Voigt<br>

------=_Part_145163_68144.1183680166229--
